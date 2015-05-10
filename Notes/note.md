# Конструкции языка
__Терм__ - основная конcтрукция.

- простые термы
    - константы
        - атомы `mia , hit_this_Qb`
        - числа `[0-9]`
    - переменные `X, Y, HitThisQ`
- составные термы `f(t_1, t_2, ... , t_n)`

Термы обрабатываются слева направо.

## Простые термы

### Переменные
- __Переменная__ - способ передачи данных во времени и пространстве.
- __Переменная__ - позволяет хранить данные и передавать их в подпрограммы.

__Именованная переменная__ - переменная, которая актуальна в рамках одного предложения.

```prolog
X , Y , ThisIsVariable
```

__Анонимная переменная__ - переменная, которая не может быть использована для передачи значения. Анонимная переменная всегда уникальна то есть любое её использование это новая переменная, с помощью которой нельзя получить доступ к значению.

```prolog
_
```

#### Неконкретизированные (свободные) переменные
Переменная является __неконкретизированной__ тогда и только тогда, когда переменная не имеет никакого значения.

#### Конкретизированные (связаные) переменные
Переменная является __конкретизированной__ тогда и только тогда, когда переменная получила значение(, при этом конкретизированная переменная не может быть изменена).

## Составные термы

---

# Программа. Deep Dive.
Программа написанная на _Prolog_ состоит из
- базы знаний    
    - фактов;
    - правил;
- запросов.

Факты, правила и запросы являются __высказываниями__.

__Высказывание (или Clause)__ - повествовательное предложение, на основании которого можно сделать вывод о его истинности или ложности.

__Замечание.__ Предложение, Утверждение, Высказывание, __Сlause__. Верти как хочешь. При попытке услышать от интерпретатора, _не понимаю, а что это такое `X`_ можно попытаться заменить слово.

__Замечание (Открываем Сибирь).__ Предложение оканчивается символом `.`.

__Замечание (Следствие Сибири).__ Факты, правила, запросы - __предложение (или `X`)__.

## База знаний
__База знаний__ - набор фактов и правил описывающие взаимоотношения некоторой предметной области.

Обрабатывается сверху внизу.

### Факт
- __Факт__ - предложение, которое устанавливает безусловно-истинное отношение между термами, или утверждает некоторую безусловную истину.
- __Факт__ - утверждение, которое всегда истинно.
- __Факт__ - безусловная истина.
- __Факт__ - констатирует, что между термами установлено отношение.
- __Факт__ - частный случай правила (то есть не имеет тела).

#### Примеры
```prolog
woman(mia). 
woman(jody).

loves(mia, jody).
```

### Правило
- __Правило__ - утверждение, которое истинно тогда и только тогда, когда выполняются условия данного правила.
- __Правило__ - предложение, которое устанавливает отношение между термами при выполнении заданных условий.
- __Правило__ - условная истина.

#### Конструкция правила
```prolog
<заголовок правила> :- <тело правила>.
```

#### Примеры
```prolog
happy(mia).                 % fact

listens2Music(mia).         % fact

listens2Music(yolanda) :-   % rule
    happy(yolanda). 

playsAirGuitar(mia) :-      % rule
    listens2Music(mia). 

playsAirGuitar(yolanda) :-  % rule
    listens2Music(yolanda).
```

## Запросы

---

# Ещё больше терминологии...

## Процедура

- __Процедура__ - совокупность фактов и правил имеющих в заголовке одинаковое имя предиката с одним и тем же количеством аргументов.
- __Процедура__ - совокупность фактов и правил, имеющих заголовок с одинаковыми главными функторами и одинаковой арностью (количество аргументов).
- __Процедура__ - описывает одно отношение, которое нельзя сформулировать одним предложением.

### Пример
```prolog
max2(X, Y, X) :-
    X > Y, !.
max2(_, Y, Y).
```

## Подстановка и пример терма
__Подстановка__ - множество пар вида `{x_i = t_i}`, где
- `x_i` переменная;
- `t_i` терм.

Если существует `A(x_1, x_2, ..., x_n)` и подстановка `theta = {x_1 = t_1, x_2 = t_2, ... , x_n = t_n}` то __применение подстановки__ обозначается `A theta` и __заключается в замене__ всех вхождений в терм `А` переменных `x_i` на значения `t_i`, где `i = 1 .. n`.

Терм `В` называется __примером терма `А`__, если существует такая подстановка `theta`, что `B = A theta`. 

Терм `C` является __общим примером термов `А`, `В`__, если существуют подстановки `theta_1`, `theta_2` такие, что C = `A theta_1`, `C = B theta_2`.

### Пример
Имеется База Знаний в которой есть факт
```prolog
p(1, R, C).
```
Базе Знаний подаётся запрос 
```prolog
?- p(x, y, z).
```

Cистема находит __общий пример__ и только тогда утверждение из Базы Знаний может считаться доказательством истинности.

---

# Правила логического вывода
__Правило вывода__ - это утверждение о взаимосвязи между допущениями и заключениями, которые справедливы всегда с позиции исчисления предикатов.

__Правило совпадения__. Система считает вопрос истиной если находит пример.

1. Если факты в программе не содержат переменных и вопрос не содержит переменных, используется _правило совпадения_.

2. Если факты содержат переменные, а вопрос основной, применяется _правило обобщения фактов_.

3. Факты и вопросы содержат переменные. Для факта выполняется _процесс конкретизации_, а потом для результата выполняется _правило обобщения_.

---

# Унификация термов
__Унификация__ - является процессом доказательства, попытка "увидеть одинаковость".

Унификация завершается либо _успехом_, либо _неудачей_. При неудачи включается _механизм отката_.

__Откат__ - возврат к предыдущему шагу.

Термы `T1` и `T2` __унифицируемы__ тогда и только тогда, когда:
- термы `T1` и `T2` являются одинаковыми константами
- терм `Т1` неконкретизированная переменная, а терм `Т2` - константа или составной терм, не содержащий внутри себя `Т1`. Тогда унификация успешна, причем `Т1` конкретизируется значением `Т2`.
- термы `Т1` и `Т2` неконкретизированные переменные. Унификация успешна всегда, причем `Т1` и `Т2` становятся сцепленными переменными - двумя именами одного "значения". В этом случае при конкретизации одной вторая получает такое же значение.
- `Т1` и `Т2` составные термы. Унификация успешна при выполнении следующих условий:
    - имеют одинаковые главные функторы
    - одинаковые арности (количество аргументов)
    - попарно унифицируются аргументы этих составных термов

Терм `S` называется __более общим чем терм `Т`__, если

1. `T` является _примером_ `S`
2. `S` не является примером T. 
 
`S` называется __наиболее общим примером `T1` и `T2`__, если `S` такой их общий пример, который является более общим по отношению к любому другому их примеру.

#### Пример
Есть терм `T = f(x1, x2, xn)`. Если одну переменную конкретизировать значением - это будет __пример__, `f(a, x2, xn)`, более общий чем `f(a, b, xn)`.

---

__Унификатор двух термов__ - подстановка, которая будучи применена к двум термам даст одинаковый результат.

__Наиболее общий унификатор двух термов__ - унификатор, соответствующий наиболее общему их примеру.

__Теорема.__ Если два терма _унифицируемы_, то существует _единственный_ с точностью до переименования переменных _наиболее общий унификатор_.

## Алгоритм унификации
Используются три области памяти:
- Cтек. Хранит равенства, унификацию которых надо доказать.
- Рабочее поле.
- Ячейка памяти. Накапливает наиболее общий унификатор.

__Флаг неудачи:__ `1` если возникла _тупиковая ситуация_

0. Начало. Доказываем `Т1 = Т2`.
1. Занести в стек `Т1 = Т2`.
2. Положить неудача `0`.
3. Пока стек не пуст
    1. считать из стека очередное равенство `С = Т`
    2. обработать считанное равенство по правилам:
        - если `С` и `Т` несовпадающие константы, то `неудача = 1`, выход из цикла
        - если одинаковые константы, то следующий шаг цикла
        - если `С` переменная и `Т` терм содержащий `С`, то `неудача = 0`, выход из цикла
        - если `С` переменная и `Т` терм не содержащий `С`, то отыскать в стеке и в результирующей ячейке все вхождения `С` и заменить на `Т`. Добавить в результирующую ячейку равенство `С = Т`. Следующий шаг цикла
        - если `С` и `Т` составные термы с разными функторами или разными арностями, то `неудача = 1`, выход из цикла
        - если `С` и `Т` составные термы с одинаковыми функторами и арностью (`S = f(s1, s2, .. sm)`; `T = f(t1, t2, ... tm)`), то занести в стек равенство `S1 = T1`, `S2 = T2` ..., `Sm = Tm`.
    3. очистить рабочее поле
4. если `неудача = 1`, то унификация невозможна 
5. если `неудача = 0` то унификация успешна, результирующая ячейка содержит наиболее общий унификатор

| step | result | cur_equation | stack |
| ---- | ------ | ------------ | ----- |
| 0    | | | `t(X, p(X, Y)) = t(q(W), p(q(a), b))` | 
| 1    | | `t(X, p(X, Y)) = t(q(W)`, `p(q(a), b))` | `X = q(W), p(X, Y) = p(q(a), b)` |
| 2    | `X = q(W)` | <--- `X = q(W) && replace("X", "q(W)")` | `p(X, Y) = p(q(a), b)` | 
| 3    | `X = q(W)` | `p(q(W), Y) = p(q(a), b)` | `q(W) = q(a), Y = b` |
| 4    | `X = q(W)` | `q(W) = q(a)` | `W = a, Y = b` |
| 5    | `X = q(W)`, `W = a` | <--- `W = a && replace("W", "a")` | `Y = b` | 
| 6    | `X = q(a)`, `W = a`, `Y = b` | <--- `Y = b` | `null` |


# Предикат
__Предикат__ - утверждение, истинность которого зависит от значения переменных, входящих в него.




# Синтаксис
- `:-` - if;
- `,` - and;
- `;` - or;
- `.` - end.