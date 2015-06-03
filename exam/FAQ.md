## Основа
### Где хранятся данные в программе?
В базе знаний (в заголовках правил).

### Что такое программа на пролог?
Программа написанная на _Prolog_ состоит из:
- базы знаний
    - фактов;
    - правил;
- запросов.

### Что такое база знаний?
__База знаний__ - набор _фактов_ и _правил_ описывающие взаимоотношения некоторой предметной области.

### Основная конструкция языка? (Что такое терм?)
Основной конструкцией языка _Prolog_ является __терм__. 
- константы
    - атомы `mia , hit_this_Qb`
    - числа `[0-9]`
- переменные `X, Y, HitThisQ`
- составные термы `f(t_1, t_2, ... , t_n)`

### Переменные в Prolog
- __именованные__:
    1. могут передавать значение в пространстве и времени;
    2. уникальны в пределах предложения, в котором используются;
    3. синтаксис: начинаются с большой буквы;
- __анонимные__:
    1. не могут передавать значение в пространстве и времени;
    2. уникальны всегда;
    3. синтаксис: подчеркивание;

### Что такое составной терм?
__Составной терм__ - истинность утверждения, что между термами-аргументами есть _связь (отношение)_. _Функтор составного терма_ отражает __связь__ между термами-аргументами.

### Что такое правило?
1. _теорема_, условная истина;
2. состоит из `<заголовок правила> :- <тело правила>.`;
3. заголовок отражает отношение между аргументами (функтор - название отношения, аргументы - объекты отношения);
4. тело правила - конъюнкция (дизъюнкция) условий истинности.

### Что такое факт?
- _аксиома_, безусловная истина;
- правило, тело которого пустое (правило без тела).

### Что такое процедура?
__Процедура__ - совокупность фактов и правил, имеющих заголовок с одинаковыми главными функторами и одинаковой арностью (количество аргументов).

### Что такое рекурсивная процедура?
__Рекурсивная процедура__ - процедура, в теле одного из правил которой есть терм, унифицирующийся с термом из заголовка одного из правил процедуры.

### Что такое знание?
__Знание__ - заголовок правила (факта).

### Как фиксируются объекты и связи между ними?
__Объекты__ фиксируются термами-аргументами правила, а __связь__ - функтором заголовка правила.


## Унификация
### Что такое унификация? Что происходит после нахождения решения
__Унификация__ - является процессом доказательства, попытка "увидеть одинаковость". 
<!-- сопоставление терма из резольвенты с термом из заголовка правила -->
### Зачем проводится унификация?
- Унификация проводится для _получения знания_, с помощью которого можно _доказать цель_.
- Подобрать знание (путем последовательного сравнения), которое предположительно можно использовать для доказательства истинности вопроса.

### Что с чем унифицируется? (Какие два терма унифицируются?)
- текущая цель из резольвенты с знанием (заголовком правила или факта);
- терм из резольвенты с термом из заголовка правила.

### Что получается в результате унификации?
Подстановка

#### Что делается с этой подстановкой?
Заменяем все переменные (из подстановки) в резольвенте на значения из подстановки.

#### Во всей резольвенте (стеке)?
Нет, на глубину одного правила.

### Что такое подстановка?
__Подстановка__ - множество пар вида `{x_i = t_i}`, где
- `x_i` - переменная;
- `t_i` - терм.
 
### Чем завершается унификация?
Унификация завершается:
- _успехом_: получаем подстановку;
- _неудачей_: включается механизм _отката_ и происходит поиск другого знания.

### Что такое редукция?
__Редукция__ - замена цели телом того правила, заголовок которого унифицируется с целью


## Резольвента
### Что такое резольвента?
__Резольвента__ - конъюнкция целей (утверждений) истинность (выводимость) которых надо доказать.

### Как меняется резольвента?
- _уменьшается_: за счет замены цели телом факта (оно пустое, его нет);
- _увеличивается_: за счёт _редукции_.

### Как растет стек в процессе обработки резольвенты?
Стек растёт _влево_. 

## Откат
### Что такое откат?
__Откат__ - возврат к предыдущему шагу.

### Механизм отката
1. Происходит возврат на предыдущий этап преобразования резольвенты.
2. Отменяется последняя выполненная редукция.
3. Выполняется реконкретизация переменных, которые были конкретизированы на последнем шаге.

### Когда происходит откат?
- резольвента пуста
- тупик

### Что такое тупик?
__Тупик__ - решение не найдено, и из данного состояния невозможен переход в новое.

### Когда будет получен ответ `да` и что будет дальше?? (условие получения ответа на вопрос)
Когда резольвента пуста, затем откат.

### Что происходит после нахождения решения?
1. Откат. 
2. Поиск нового решения, пока все метки не окажутся в конце базы знаний.