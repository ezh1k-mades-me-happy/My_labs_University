/* ──────────────────── *
│  Лишнее присваивание │
* ──────────────────── */

int k3;

int main( argc, argv )
     int argc;
     char **argv;
{
    k3 = 1;
    k3 = 1;

    return k3;
}
