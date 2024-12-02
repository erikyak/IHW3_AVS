
1. ФИО: Яковлев Эрик денисович
2. Группа: БПИ239
3. - Вариант: 22
   - Текст задачи: Разработать программу, вычисляющую число вхождений различных знаков препинания в заданной ASCII–строке. Вывод
результатов организовать в файл (используя соответствующие преобразования чисел в строки).
4. Метод решения задачи:  
  4.1. Пользователь выбирает: или прогнать тесты или ввести путь к файлу вручную  
  4.2. Если прогоняются тесты, то считываются файлы, выводятся количество знаков препинания, и записывается в файлы  
  4.3. Если пользователь вводит вручную, то сначала вводится путь к файлу для чтения, считаются знаки препинания, пользователь выбирает выводить или нет количество знаков препинания,
   и все записывается в файл, название и путь к которому вводит пользователь  

<details>
  <summary>Скриншоты кода программы</summary>

## main.s
<img width="995" alt="Снимок экрана 2024-12-02 в 23 13 53" src="https://github.com/user-attachments/assets/7541bda7-ddc1-4678-b96d-fc0563d9cc2c">

## keyboard.s
<img width="994" alt="Снимок экрана 2024-12-02 в 23 14 21" src="https://github.com/user-attachments/assets/69c3a5f8-e284-4b73-8de4-23cb5acfaad3">
<img width="991" alt="Снимок экрана 2024-12-02 в 23 14 40" src="https://github.com/user-attachments/assets/1f6a5c73-ccc3-4f22-878d-e607eb596f5d">

## tests.s
<img width="994" alt="Снимок экрана 2024-12-02 в 23 15 06" src="https://github.com/user-attachments/assets/b6675b18-a05a-419b-a74b-1c0f4afa4878">

## macrolib.s
<img width="995" alt="Снимок экрана 2024-12-02 в 23 15 52" src="https://github.com/user-attachments/assets/162a9549-3a44-4cb6-ad1b-96e94781efef">
<img width="993" alt="Снимок экрана 2024-12-02 в 23 16 20" src="https://github.com/user-attachments/assets/cf74bdbe-fb49-43da-a15c-e0f7ec16f757">
<img width="993" alt="Снимок экрана 2024-12-02 в 23 16 59" src="https://github.com/user-attachments/assets/f59f4251-a3bf-45e9-986f-a2886636a07e">
<img width="995" alt="Снимок экрана 2024-12-02 в 23 17 14" src="https://github.com/user-attachments/assets/f5de8005-0677-4a76-a78c-f386552b7624">
<img width="995" alt="Снимок экрана 2024-12-02 в 23 17 32" src="https://github.com/user-attachments/assets/cfcd4a6f-e519-4855-8905-e330a72d4acd">
<img width="994" alt="Снимок экрана 2024-12-02 в 23 17 52" src="https://github.com/user-attachments/assets/2dd0021e-fe12-4e1a-b86c-7a02a3129706">
<img width="994" alt="Снимок экрана 2024-12-02 в 23 18 28" src="https://github.com/user-attachments/assets/37ad7e2a-0386-46fe-8951-850e540163c8">
</details>

<details>
  <summary>Отчет</summary>

## На 4-5 баллов
Разработана программа, считающая количество знаков препинания и выводящяя это в другой файл
Скриншоты тестирования программы:  
<img width="634" alt="Снимок экрана 2024-12-02 в 23 25 40" src="https://github.com/user-attachments/assets/08ecdaa1-a3f5-46fe-8b54-8a131dfe1765">
<img width="389" alt="Снимок экрана 2024-12-02 в 23 26 02" src="https://github.com/user-attachments/assets/22306ac5-6b9d-4272-9672-e2d8e277794f">
<img width="926" alt="Снимок экрана 2024-12-02 в 23 26 27" src="https://github.com/user-attachments/assets/30b3f386-2a59-4bac-b7f8-a94bacb74a1a">
### Commas.txt
<img width="647" alt="Снимок экрана 2024-12-02 в 23 27 30" src="https://github.com/user-attachments/assets/2de80d13-1942-4f35-aee1-8eb059be96f4">

### outputing_commas.txt
<img width="646" alt="Снимок экрана 2024-12-02 в 23 28 01" src="https://github.com/user-attachments/assets/7343c1bb-024b-4458-a117-ca936025e7a5">

## На 6-7 баллов
Был изменен код и поэтому добавленны следующие подпрограммы(соблюдающие конвенцию):
### read_from_file
Считывает текст файла с заданного пути 
### marks_count
Считает количество знаков препинания из строки
### write_file
Записывает строку в файл, путь к котору задан
### read_str_dial
Считывает строку с диалогового окна

## На 8 баллов
Добавлена тестовая подпрограмма тем самым общая программа разбита на main(с него начинается программа), 
keyboard(для считывания n с клавиатуры), tests(для прогона тестов).  
Для выбора использовать тесты или вводить вручную в main добавлен ввод числа, в котором пользователь решает что он хочет(0 - ввод с клавиатуры, 
1(на самом деле все, кроме 0) - прогон тестов).  
Также была добавлена подпрограмма want_print для вывода количества знаков препинания по желнию пользователя

Скриншот прогона тестов:  
<img width="635" alt="Снимок экрана 2024-12-02 в 23 21 58" src="https://github.com/user-attachments/assets/7168bf1c-0cf8-4287-81c9-ee1297859e28">
<img width="923" alt="Снимок экрана 2024-12-02 в 23 22 22" src="https://github.com/user-attachments/assets/926185b5-e0c8-416a-9fec-5c3e964e67b9">
<img width="924" alt="Снимок экрана 2024-12-02 в 23 22 37" src="https://github.com/user-attachments/assets/ded7ac9a-dae0-4566-a622-918ff0ec52fe">
<img width="923" alt="Снимок экрана 2024-12-02 в 23 22 47" src="https://github.com/user-attachments/assets/5b78e3be-6271-4297-8e79-a8ec0c929b8f">


## На 9 баллов
Все подпрограммы(кроме keyboard и tests) были обернуты в макросы, убрано сохранение ra(так как макросы его не изменяют, в отличие от подпрограмм).  
Также tests был переделан, теперь он вызывает макросы с разными пресетами.

## На 10 баллов
Программа теперь разбита на 7 ассемблерных файла main.s(начало программы), keyboard.s(для считывания n с клавиатуры), tests.s(для прогона тестов), macrolib.s 
(для всех макросов), marks_count.s(для подсчета количества знаков препинания), read_from_file.s(для считывания файла), write_file.s(для записи в файл).  
Программа успешно работает как раньше (_при учете включения Assemble all files in directory и Initialize Program Counter to global 'main' if defined_).  
Также теперь вызываются диалоговые окна для общения между программой и пользователем
</details>
