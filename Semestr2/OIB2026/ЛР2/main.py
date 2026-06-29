RUS_FREQ = "ОЕАИНТСРЛВКПМУЯДЫЬБГЗЙЧХШЖЦЩЮЭФЪ"
# FILE_NAME = "crypt_big.txt"
FILE_NAME = "CrimeAndPun_Crypt.txt"
text = ""
substitution = {}
history = []

with open(FILE_NAME, 'r', encoding='utf-8') as f:
    text = f.read().upper()

text = text.replace('Ё', 'Е')

print(f"Длина текста: {len(text)} символов.")


def get_freq_sorted():
    counter = {}
    for char in text:
        if 'А' <= char <= 'Я':
            counter[char] = counter.get(char, 0) + 1

    total = sum(counter.values())
    freq_dict = {char: cnt / total for char, cnt in counter.items()}
    sorted_chars = sorted(counter, key=counter.get, reverse=True)
    return freq_dict, sorted_chars


def decrypt():
    result = []
    for char in text:
        if char in substitution:
            result.append(substitution[char])
        else:
            result.append(char)
    return "".join(result)


def apply(crypt_char, new_char):
    crypt_char = crypt_char.upper()
    new_char = new_char.lower()
    old_val = substitution.get(crypt_char, None)
    if old_val is not None:
        print(f"Буква {crypt_char} Уже была дешифрована! {crypt_char} -> {old_val}")
    history.append((crypt_char, old_val, new_char))
    substitution[crypt_char] = new_char




def undo():
    if history:
        char, old_val, new_val = history.pop()
        if old_val is None:
            substitution.pop(char, None)
        else:
            substitution[char] = old_val
        print(f"Отменена замена для буквы {char} ({new_val} -> {old_val if old_val else 'None'})")
    else:
        print("История пуста")


def show_header(title):
    print("\n" + "=" * 60)
    print(title)
    print("=" * 60)


def freq_analysis():
    show_header("ЧАСТОТНЫЙ АНАЛИЗ")
    freq_dict, sorted_chars = get_freq_sorted()
    print(f"{'Буква шифра':<12} | {'Частота':<10} | {'Предложение'}")
    print("-" * 60)
    for i, char in enumerate(sorted_chars):
        suggestion = RUS_FREQ[i]
        print(f"{char:<12} | {freq_dict.get(char, 0):.4f}     | {suggestion}")


def group_by_len():
    show_header("СЛОВА ПО ДЛИНЕ")
    groups = {}
    for word in decrypt().split():
        clean = "".join(c for c in word if c.isalpha())
        if clean:
            groups.setdefault(len(clean), []).append(clean)

    for length in sorted(groups):
        unique = list(set(groups[length]))
        print(f"Длина {length}: {unique}")


def group_by_unknown():
    show_header("СЛОВА ПО НЕРАСШИФРОВАННЫМ")
    groups = {}
    for word in decrypt().split():
        count = sum(1 for c in word if 'А' <= c <= 'Я' and c.isupper())
        if count > 0:
            groups.setdefault(count, []).append(word if count == len(word) else word[:-1])

    for count in sorted(groups):
        print(f"Нерасшифровано {count}: {list(set(groups[count]))}")


def show_text():
    show_header("ТЕКУЩИЙ ТЕКСТ\nЗаглавные = шифр, Строчные = расшифровано")
    print(decrypt())


def show_table():
    show_header("ТАБЛИЦА ПОДСТАНОВКИ")
    if not substitution:
        print("Пока нет замен.")
    else:
        for k, v in sorted(substitution.items()):
            print(f"{k} -> {v}")


def auto_substitute(last_char):
    print("\nАвтоматическая подстановка...")
    freq_dict, sorted_chars = get_freq_sorted()
    count = 0
    for i, char in enumerate(sorted_chars):
        if last_char.upper() == char:
            break
        if i < len(RUS_FREQ):
            apply(char, RUS_FREQ[i])
            count += 1
    print(f"Применено {count} замен (добавлено в историю)")
    show_text()


def show_history():
    show_header(f"ИСТОРИЯ ЗАМЕН ({len(history)} записей)")
    if not history:
        print("История пуста")
    else:
        print(f"{'№':<4} | {'Шифр':<6} | {'Было':<6} | {'Стало':<6}")
        print("-" * 60)
        for i, (char, old_val, new_val) in enumerate(history, 1):
            old_str = old_val if old_val else "None"
            print(f"{i:<4} | {char:<6} | {old_str:<6} | {new_val:<6}")


def undo_all_auto():
    count = min(len(RUS_FREQ), len(history))
    for _ in range(count):
        if history:
            char, old_val, new_val = history.pop()
            if old_val is None:
                substitution.pop(char, None)
            else:
                substitution[char] = old_val
    print(f"Отменено {count} замен")


while True:
    print("\n--- МЕНЮ ---")
    print("1. Частотный анализ  \n2. Слова по длине  \n3. Слова по нерасшифрованным")
    print("4. Показать текст    \n5. Заменить букву   \n6. Отменить замену")
    print("7. Таблица подстановки  \n8. Авто-замена  \n9. Отменить авто  \n10. История\n0. Выход")

    cmd = input("\nКоманда: ")

    if cmd == '1':
        freq_analysis()
    elif cmd == '2':
        group_by_len()
    elif cmd == '3':
        group_by_unknown()
    elif cmd == '4':
        show_text()
    elif cmd == '5':
        parts = input("БукваШифра БукваОткрытого (А о): ").split()
        if len(parts) == 2:
            apply(parts[0], parts[1])
            print(f"Замена {parts[0]} -> {parts[1]} применена")
    elif cmd == '6':
        undo()
    elif cmd == '7':
        show_table()
    elif cmd == '8':
        auto_substitute(input("Введите букву до которой нужно делать автозамену: "))
    elif cmd == '9':
        undo_all_auto()
    elif cmd == '10':
        show_history()
    elif cmd == '0':
        print("\nЗавершение работы.")
        break
    else:
        print("Неизвестная команда")
