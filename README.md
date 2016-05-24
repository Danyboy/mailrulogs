## Separator

### Пример запуска для разбора events:

```bash
 cat example.log | ./separator.sh
```

### Запуск для разбора реальных данных на примере айпи адресов:
```bash
 cat myexample.log | time ./ip_separator.sh
```

## Анализ результатов

### Наивный вариант
Лог размером 42714K разбирается ~13 минут для варианта
```bash
 echo "$@" >> "$outdir/$(echo "$@" | grep -Eo -m1 "${regexp}").log"
```
Что даёт очень медленную скорость = 53 KB / sec

### xargs
использоваие xars 
```bash
 xargs -n1 -P4 -I file sh -c 'echo "file" >> $(echo "file"| cut -c1-15 | grep -Eo -m1 "([0-9]{1,3}[\.]){3}[0-9]{1,3}").log'
```
даёт двухкратное ускроние до 6 минут

```bash
 cat myexample.log | time ./ip_separator.sh
 381.28user 829.55system 6:03.07elapsed 333%CPU (0avgtext+0avgdata 2532maxresident)k
 5000inputs+78464outputs (33major+84975172minor)pagefaults 0swaps
```
 
Основная задержка от поиска айпи адреса регулярными выражениями и построчной записи в разные файлы.

## Задание 3

3. Некая программа отслеживает происходящие в системе события и генерирует большой поток логов (тысячи записей в секунду по 200-300 байт каждая, единицы новых событий в секунду). Логи отдаются общим потоком в STDOUT, в каждой строке присутствует ключ события вида event_key=ID, в первой записи для данного ключа в строке присутствует event_start, в последней - event_stop.
Например,
```bash
some_text .... event_start ... event_key=1234567 ...some_text...
some_text .... event_key=1234567 ...some_text...
some_text .... event_start ... event_key=2345678 ...some_text...
some_text .... event_key=2345678 ...some_text...
.....тысячи записей....
some_text .... event_key=1234567 ...some_text...
some_text .... event_stop ... event_key=1234567 ...some_text...
some_text .... event_key=2345678 ...some_text...
some_text .... event_stop... event_key=2345678 ...some_text...
Необходимо написать скрипт, передавая на вход которому поток с логами о событиях, на выходе получим сгруппированные по событиям файлы - по одному на каждое событие. Для примера выше получим два файла -
1234567.log
some_text .... event_start ... event_key=1234567 ...some_text...
some_text .... event_key=1234567 ...some_text...
...
some_text .... event_key=1234567 ...some_text...
some_text .... event_stop ... event_key=1234567 ...some_text...
2345678.log
some_text .... event_start ... event_key=2345678 ...some_text...
some_text .... event_key=2345678 ...some_text...
...
some_text .... event_key=2345678 ...some_text...
some_text .... event_stop... event_key=2345678 ...some_text...
```

Порядок записей в результирующих файлах должен совпадать с порядком во входном потоке. Необходимо учесть объемы и скорость поступления данных

## Задание 1

1. Бранч SVN svn://svn_server/branches/some_feature_branch был удален в ревизии 112233. Как его восстановить?


```bash
 svn cp svn://myrepo.com/svn/branches/some_feature_branch@112232 \
       svn://myrepo.com/svn/branches/some_feature_branch_restored
```

## Задание 2

2. Разработка новой функции активно велась в feature-branch'е на протяжении длительного периода. Регулярно выполнялся merge из trunk'а. Как выявить изменения, внесенные именно в рамках разработки новой функции?


Как выявить изменения, если merge из trunk'а не выполнялся?

```bash
svn diff -r revidion_of_branch_creation:HEAD URL/branch/path
```



