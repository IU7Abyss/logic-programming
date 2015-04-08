# Введение в Prolog
Декларативный язык программирования.

Системе подаётся _совокупность знаний_.

В основе логического программирования - _признак резолюций__ (1965) (на принципе придикатов).

*Предикат* - логическая функция.

*Высказывание* - утверждение.

Виды выражений:
  - правила;
  - факты (на самом деле частный случай _правила_).

В прологе используется _база знаний_.

Основополагающий принцип работы - абсолютный недотерминизм, то есть неопределённый порядок последовательности действий для получения ответа.



## Особенности знаний

- Знания более _структурированы_ чем данные. То есть знания определяется на основе _простых понятий_.
- Знания обладают _внутренней интерпретируемостью_ (более содержательные), данные требуют _внешней интерпретации_.
- Знания обладают _взаимосвязанностью_. Именно это позволяет делать выводы.
- Знания обладают _активными_ и _пассивными_ аспектами.



## Основные конструкции

Основная (и единcтвенная) конструкция - `term`

```
константа || переменная || структура (составной term)
```


### Константы 
- нечисловые (атомы);
- символьные;
- числа.


### Переменные
Начинаются с _заглавной буквы_ или с _символа подчёркивания_. `_` - анонимная переменная.

Говорят что _переменная_ может быть связана с некоторым значением или оставаться независимой. Принцип деструтивного связывания.

*Анонимная переменная* - если передавать данных не нужно, то есть никогда не может быть использованая для передачи значения

Именованные переменные уникальны в рамке одного предложения (предложение заканчивается символом `.`). Анонимная переменная всегда уникальна.

#### Минута философии
> Переменная - это способ передачи данных во времени и пространстве

Специальные атомы: `:-`, `?-`.


### Составные term

```
f(t_1, t_2, ..., t_n)
```
- `f` - функтор (но это не функция и язык не функциональной, только лишь похожа внешне);
- `t_1, t_2, ..., t_n` - term.

*Функтор* - имя отношения между объектами.

Составной term фиксирует _знание_ о том, что между terms существует некоторая связь.



## Структура программы

Проограмма состоит из
- базы знаний;
- вопросов.

Исходными данными являются _вопросы_

Есть факт - `student(ivanov, mGTU)`. Системе подаётся вопрос - `student(ivanov, mGTU)`.

Если совпадают главные функторы, количество term, и сами term - то успех.

На один и тот же вопрос можно получить несколько ответов.

### Правила
```
<заголовок правила> :- <тело правила>
```
```
f_p(t_1, t_2, ..., t_n) :- A_1, A_2, ..., A_n
```
- `A_1, A_2, ..., A_n` - утверждения.

При этом в _теле правила_ может употребляться:
- `,` коньюнкиция утверждений;
- `;` дизьюнкиция утверждений.