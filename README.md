cat example.log | ./separator.sh #run

3. Некая программа отслеживает происходящие в системе события и генерирует большой поток логов (тысячи записей в секунду по 200-300 байт каждая, единицы новых событий в секунду). Логи отдаются общим потоком в STDOUT, в каждой строке присутствует ключ события вида event_key=ID, в первой записи для данного ключа в строке присутствует event_start, в последней - event_stop.
Например,
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
Порядок записей в результирующих файлах должен совпадать с порядком во входном потоке. Необходимо учесть объемы и скорость поступления данных