extern int main(void);

void __start(void)
{
    main();
    while (1);
}
