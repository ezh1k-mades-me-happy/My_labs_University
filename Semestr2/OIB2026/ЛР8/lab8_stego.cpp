#include <stdio.h>
#include <stdlib.h>

#define BMP_HEADER_SIZE 54
#define METADATA_SIZE 5

void show_menu();
int get_encoding_depth();
long calculate_capacity(long pixel_count, int depth);
int encode_message();
int decode_message();
long get_bmp_pixel_count(const char* filename);
void clear_input_buffer();
void write_byte(FILE* in, FILE* out, unsigned char byte, int depth, unsigned char masks[2]);
unsigned char extract_byte(FILE* in, int depth, unsigned char bit_mask);

int main() {
    int choice;
    do {
        show_menu();
        printf("Your choice: ");

        if (scanf("%d", &choice) != 1) {
            clear_input_buffer();
            choice = -1;
        } else {
            clear_input_buffer();
        }

        switch(choice) {
            case 1: encode_message(); break;
            case 2: decode_message(); break;
            case 0: printf("Exiting...\n"); break;
            default: printf("Invalid choice.\n");
        }

        if (choice != 0) {
            printf("\nPress Enter to continue...");
            getchar();
        }
    } while (choice != 0);

    return 0;
}

void show_menu() {
    printf("1. Encode message\n");
    printf("2. Decode message\n");
    printf("0. Exit\n");
}

int get_encoding_depth() {
    int depth;
    printf("\nEnter encoding depth (1-7): ");

    while (scanf("%d", &depth) != 1 || depth < 1 || depth > 7) {
        printf("Error. Enter 1-7: ");
        clear_input_buffer();
    }
    clear_input_buffer();
    return depth;
}

void clear_input_buffer() {
    int c;
    while ((c = getchar()) != '\n' && c != EOF);
}

long get_bmp_pixel_count(const char* filename) {
    FILE* bmp = fopen(filename, "rb");
    if (!bmp) return -1;

    fseek(bmp, 18, SEEK_SET);
    unsigned char dims[8];
    fread(dims, 1, 8, bmp);
    fclose(bmp);

    int width = dims[0] | (dims[1] << 8) | (dims[2] << 16) | (dims[3] << 24);
    int height = dims[4] | (dims[5] << 8) | (dims[6] << 16) | (dims[7] << 24);

    return (long)width * (height > 0 ? height : -height);
}

long calculate_capacity(long pixel_count, int depth) {
    // (pixels × 3 color channels × depth bits) / 8 bits per byte - metadata - null terminator
    long color_bytes = pixel_count * 3;
    long total_bits = color_bytes * depth;
    long total_symbols = total_bits / 8;
    return total_symbols - METADATA_SIZE - 1;
}

void write_byte(FILE* in, FILE* out, unsigned char byte, int depth, unsigned char masks[2]) {
    unsigned char pixel, clear_mask = masks[1];
    int bits_written = 0;

    while (bits_written < 8) {
        fread(&pixel, 1, 1, in);
        int bits_available = 8 - bits_written;
        int bits_to_take = (bits_available < depth) ? bits_available : depth;

        unsigned char current_mask = (1 << bits_to_take) - 1;
        int shift = bits_available - bits_to_take;
        unsigned char bits = (byte >> shift) & current_mask;

        bits = bits << (depth - bits_to_take);
        pixel = (pixel & clear_mask) | bits;
        fwrite(&pixel, 1, 1, out);
        bits_written += bits_to_take;
    }
}

unsigned char extract_byte(FILE* in, int depth, unsigned char bit_mask) {
    unsigned char pixel;
    unsigned int accumulator = 0;
    int bits_collected = 0;

    while (bits_collected < 8) {
        if (fread(&pixel, 1, 1, in) != 1) {
            return 0;
        }

        int bits_needed = 8 - bits_collected;
        int bits_to_extract = (bits_needed < depth) ? bits_needed : depth;
        unsigned char bits = (pixel & bit_mask) >> (depth - bits_to_extract);

        accumulator = (accumulator << bits_to_extract) | bits;
        bits_collected += bits_to_extract;
    }

    return accumulator & 0xFF;
}

int encode_message() {
    printf("\n=== ENCODE ===\n");
    int depth = get_encoding_depth();
    long pixels = get_bmp_pixel_count("image.bmp");
    if (pixels < 0) {
        printf("Error: cannot read image.bmp\n");
        return 1;
    }

    long max_chars = calculate_capacity(pixels, depth);
    printf("Pixels: %ld | Depth: %d | Max message: %ld chars\n", pixels, depth, max_chars);

    FILE* msg_file = fopen("text.txt", "r");
    if (!msg_file) {
        printf("Error: cannot open text.txt\n");
        return 1;
    }

    fseek(msg_file, 0, SEEK_END);
    long file_size = ftell(msg_file);

    fseek(msg_file, 0, SEEK_SET);

    if (file_size > max_chars) {
        printf("\n=== ENCODING FAILED ===\n");
        printf("Message larger then container\n");
        printf("File size: %ld bytes\n", file_size);
        printf("Maximum capacity: %ld bytes\n", max_chars);
        fclose(msg_file);
        return 1;
    }

    char* message = (char*)malloc(file_size + 1);
    if (!message) {
        printf("Error: memory allocation failed\n");
        fclose(msg_file);
        return 1;
    }

    size_t len = fread(message, 1, file_size, msg_file);
    message[len] = '\0';
    fclose(msg_file);

    printf("Loaded message from text.txt: %ld bytes\n", (long)len);

    FILE* in = fopen("image.bmp", "rb");
    FILE* out = fopen("stego_image.bmp", "wb");
    if (!in || !out) {
        printf("Error: cannot open image files\n");
        if (in) fclose(in);
        if (out) fclose(out);
        free(message);
        return 1;
    }

    unsigned char header[BMP_HEADER_SIZE];
    fread(header, 1, BMP_HEADER_SIZE, in);
    fwrite(header, 1, BMP_HEADER_SIZE, out);

    unsigned char masks[2] = {(unsigned char)((1 << depth) - 1), (unsigned char)(~((1 << depth) - 1) & 0xFF)};

    printf("Embedding metadata (len=%ld, depth=%d)...\n", (long)len, depth);
    for (int i = 3; i >= 0; i--) {
        unsigned char len_byte = ((unsigned int)len >> (8 * i)) & 0xFF;
        write_byte(in, out, len_byte, depth, masks);
    }

    write_byte(in, out, (unsigned char)depth, depth, masks);

    for (size_t i = 0; i < len; i++) {
        write_byte(in, out, (unsigned char)message[i], depth, masks);
    }

    write_byte(in, out, 0, depth, masks);
    unsigned char pixel;
    while (fread(&pixel, 1, 1, in) == 1) {
        fwrite(&pixel, 1, 1, out);
    }

    fclose(in);
    fclose(out);
    free(message);

    printf("Done.\n");
    return 0;
}

int decode_message() {
    printf("\n=== DECODE ===\n");

    FILE* in = fopen("stego_image.bmp", "rb");
    if (!in) {
        printf("Error: cannot open stego_image.bmp\n");
        return 1;
    }

    fseek(in, BMP_HEADER_SIZE, SEEK_SET);

    int depth = 0;
    unsigned int msg_len = 0;

    for (int test_depth = 1; test_depth <= 7; test_depth++) {
        fseek(in, BMP_HEADER_SIZE, SEEK_SET);
        unsigned char bit_mask = (1 << test_depth) - 1;
        unsigned int test_len = 0;

        for (int i = 3; i >= 0; i--) {
            unsigned char b = extract_byte(in, test_depth, bit_mask);
            test_len |= ((unsigned int)b << (8 * i));
        }

        int stored_depth = extract_byte(in, test_depth, bit_mask);

        if (stored_depth == test_depth && test_len > 0) {
            long pixels = get_bmp_pixel_count("stego_image.bmp");
            long max_possible = (pixels * 3 * test_depth) / 8 - METADATA_SIZE - 1;
            if (test_len <= (unsigned int)max_possible) {
                depth = test_depth;
                msg_len = test_len;
                break;
            }
        }
    }

    if (depth == 0) {
        printf("Error: cannot detect encoding parameters\n");
        fclose(in);
        return 1;
    }
    printf("Detected: depth=%d, length=%u\n", depth, msg_len);

    fseek(in, BMP_HEADER_SIZE, SEEK_SET);
    unsigned char bit_mask = (1 << depth) - 1;

    for (int i = 0; i < METADATA_SIZE; i++) {
        extract_byte(in, depth, bit_mask);
    }

    printf("Message: \"");
    char* message = (char*)malloc(msg_len + 1);
    if (!message) {
        printf("Error: memory allocation failed\n");
        fclose(in);
        return 1;
    }

    for (unsigned int i = 0; i < msg_len; i++) {
        message[i] = extract_byte(in, depth, bit_mask);
        putchar((message[i] >= 32 && message[i] <= 126) ? message[i] : '.');
    }
    message[msg_len] = '\0';
    printf("\"\n");

    fclose(in);
    free(message);
    printf("Decoding complete.\n");
    return 0;
}