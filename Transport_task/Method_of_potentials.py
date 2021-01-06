from tkinter import *
#import time
""" S,M - колличество складов и магазинов
    SX, MX - служат для создания виджетов
    arrS, arrM - нужны для хранения необходимых условий
    arrP - массив цен
    arrP_vid - массив виджетов для цен
    arrRes - массив ответа и решения"""
#global S, M, MX, SX, arrS, arrM, arrP, arrP_vid, arrRes


def func_min(cycle_sign, Resarr, s, m):
    """Производит поиск минимального элемента матрицы, из отмеченных знаком -.
    На вход: Матрица знаков(+,-,#,?), Матрица решения, кол-во складов и магазинов
    На выходе: список с минимальными элементами, сам минимум, и кол-во с этим мин."""
    list_min = []
    n = 0
    _min = -1
    for i in range(s):
        for j in range(m):
            if cycle_sign[i][j]== '-':
                if Resarr[i][j] < _min or _min == -1:
                    _min = int(Resarr[i][j])
                    n = 1
                    list_min = []
                    list_min.append([i,j])
                elif Resarr[i][j] == _min:
                    n += 1
                    list_min.append([i,j])
    return list_min, _min, n
            

def proverka(c_s, Resarr, sm, cij, ch):
    """Производит поиск сл элемента для цикла перераспределения
    На вход: матрица знаков, матрица решения, критерий поиска(3 шт)
    На выходе: координаты найденого элемента, или !,!"""
    for i in range(sm):
        if ch == 's':
            if Resarr[i][cij] != '-' and c_s[i][cij] == '?':
                return i, cij
        elif ch == 'm':
            if Resarr[cij][i] != '-' and c_s[cij][i] == '?':
                return cij, i
    return '!', '!'
        
def creation_cycle(i1, j1, Resarr, cycle_sign, s, m):
    """Функция для создания цикла перераспределения товарооборота
    На вход: координаты ячейки, не прошедшие условия оптимальности,
    Матрица решения, "черновая" матрица знаковб кол-во складов и магазинов.
    На выходе: заполненая матрица знаков"""
    q = 0
    cycle_sign[i1][j1] = '+'
    flag = False
    while flag == False:
        p = []
        i3, j3 = i1, j1
        flag2 = False
        while flag2 == False:
            i2, j2 = proverka(cycle_sign ,Resarr, s if q==0 else m , j3 if q==0 else i3, 's' if q==0 else 'm')
            if i2=='!':
                p.pop()
                q = (q+1)%2
                if len(p)==0:
                    break
                i3, j3 = p[-1][0], p[-1][1]
                continue
            p.append([i2,j2])
            q = (q+1)%2
            cycle_sign[i2][j2] = '#'
            i3, j3 = i2, j2
            if i1==i3:
                flag2 = True
        if len(p)!=0:
            q = 1
            for z in range(len(p)):
                cycle_sign[p[z][0]][p[z][1]] = '+' if q==0 else '-'
                q = (q+1)%2
            flag = True
    return cycle_sign
            
def poisk_for_cikl(s, m, poten_S, poten_M, Parr):
    """Производит поиск ячейки, не прошедшая условия оптимальности
    На вход: кол-во магазинов и складов, потенциалы магазинов и складов, матрица цен
    На выходе: координата ячейки"""
    i = 0
    j = 0
    for i in range(s):
        for j in range(m):
            if int(poten_S[i])+int(poten_M[j])>int(Parr[i][j]):
                return i, j

def decision_func(Sarr, Marr, Parr, Resarr, s, m):
    """Функция, решающая Транспортную задачу
    На вход: Число магазинов, складов, необходимого товара, имеющегося товара, матрица цен
    а так же  "черновая" заготовка матрицы решения
    На выходе: матрица решения (результата)"""
    timeS = list(Sarr)
    timeM = list(Marr)
    poten_M = ['?' for i in range(m)]
    poten_S = ['?' for i in range(s)]
    for i in range(s):
        for j in range(m):
            if Resarr[i][j]=='?':
                tmp = min(int(timeS[i]), int(timeM[j]))
                Resarr[i][j] = tmp
                timeS[i] = int(timeS[i]) - tmp
                timeM[j] = int(timeM[j]) - tmp
                if timeS[i]==0 and timeM[j]!=0: 
                    for k in range(m):
                        if Resarr[i][k]=='?':
                            Resarr[i][k] = '-'
                elif timeM[j]==0 and timeS[i]!=0:
                    for k in range(s):
                        if Resarr[k][j]=='?':
                            Resarr[k][j] = '-'
                else:
                    for k in range(m):
                        if Resarr[i][k]=='?':
                            Resarr[i][k] = '-'
                    for k in range(s):
                        if Resarr[k][j]=='?':
                            Resarr[k][j] = '-'
                    if i!=s-1 or j!=m-1:
                        if j==m-1:
                            Resarr[i+1][j] = 0
                        else:
                            Resarr[i][j+1] = 0
                        
    poten_S[0] = 0
    newflag = True
    for i in range(s):
        newflag = newflag and poten_S[i]!='?'
    for j in range(m):
        newflag = newflag and poten_M[i]!='?'
    while newflag==False:
        newflag = True
        for i in range(s):
            for j in range(m):
                if Resarr[i][j] != '-':
                    if poten_S[i]== '?' and poten_M[j] != '?':
                        poten_S[i] = int(Parr[i][j]) - int(poten_M[j])
                    elif poten_M[j] == '?' and poten_S[i]!= '?':
                        poten_M[j] = int(Parr[i][j]) - int(poten_S[i])
                    if poten_M[j] == '?' and poten_S[i]== '?' and i==s-1 and j==m-1:
                        poten_S[i] = Parr[i][j]
                        poten_M[j] = 0
                    elif poten_M[j] == '?' and poten_S[i]== '?' and Resarr[i][j] != '-':
                        newflag=False
                        continue
    sign = True
    for i in range(s):
        for j in range(m):
            if Resarr[i][j] == '-':
                sign = sign and int(poten_S[i])+int(poten_M[j])<=int(Parr[i][j])
    i = 0
    j = 0
    while sign==False:
        cycle_sign = [['?' for i in range(m)] for j in range(s)]
        i1, j1 = poisk_for_cikl(s, m, poten_S, poten_M, Parr)
        cycle_sign = creation_cycle(i1, j1, Resarr, cycle_sign, s, m)
        poten_M = ['?' for i in range(m)]
        poten_S = ['?' for i in range(s)]
        timeS = list(Sarr)
        timeM = list(Marr)
        list_min, _min, n = func_min(cycle_sign, Resarr, s, m)
        for i in range(s):
            for j in range(m):
                if cycle_sign[i][j] == '-':
                    Resarr[i][j] = int(Resarr[i][j]) - _min
                elif cycle_sign[i][j] == '+' and Resarr[i][j]!= '-':
                    Resarr[i][j] = int(Resarr[i][j]) + _min
                elif cycle_sign[i][j] == '+' and Resarr[i][j]== '-': 
                    Resarr[i][j] = _min
        Resarr[list_min[-1][0]][list_min[-1][1]] = '-'      
        poten_S[0] = 0
        newflag = True
        for i in range(s):
            newflag = newflag and poten_S[i]!='?'
        for j in range(m):
            newflag = newflag and poten_M[i]!='?'
        while newflag==False:
            newflag = True
            for i in range(s):
                for j in range(m):
                    if Resarr[i][j] != '-':
                        if poten_S[i]== '?' and poten_M[j] != '?':
                            poten_S[i] = int(Parr[i][j]) - int(poten_M[j])
                        elif poten_M[j] == '?' and poten_S[i]!= '?':
                            poten_M[j] = int(Parr[i][j]) - int(poten_S[i])
                        if poten_M[j] == '?' and poten_S[i]== '?' and Resarr[i][j] != '-':
                            newflag=False
                            continue
        sign = True
        for i in range(s):
            for j in range(m):
                if Resarr[i][j] == '-':
                    sign = sign and int(poten_S[i])+int(poten_M[j])<=int(Parr[i][j])
    return Resarr                

def my_report(Result):
    """Функция составления отчета"""
    global arrRes
    global S_new, M_new
    global S, M
    global report_S, report_M
    vidg = []
    t=0
    report = Toplevel()
    report.title("Отчет")
    report.geometry("500x400")
    for i in range(S):
        vidg.append(0)
        my_text = 'скл'+str(i+1)
        vidg[t] = Label(report, text = my_text,width = 4, height=1,bg='gray',fg='black',font='arial 10')
        vidg[t].grid(row = i+2, column = 1)
        t+=1
        tmp = i
    if S!=S_new:
        vidg.append(0)
        vidg[t] = Label(report, text = 'долг',width = 4, height=1,bg='gray',fg='black',font='arial 10')
        vidg[t].grid(row = tmp+3, column = 1)
        t+=1
    for i in range(M):
        vidg.append(0)
        my_text = 'м'+str(i+1)
        vidg[t] = Label(report, text = my_text,width = 3, height=1,bg='gray',fg='black',font='arial 10')
        vidg[t].grid(row = 1, column = i+2)
        t+=1
        tmp = i
    if M!=M_new:
        vidg.append(0)
        vidg[t] = Label(report, text = 'ост',width = 3, height=1,bg='gray',fg='black',font='arial 10')
        vidg[t].grid(row = 1, column = tmp+3)
        t+=1
    for i in range(S_new):
        for j in range(M_new):
            vidg.append(0)
            vidg[t] = Label(report, text = str(arrRes[i][j]),width = 3, height=1,bg='white',fg='black',font='arial 10')
            vidg[t].grid(row = i+2, column = j+2)
            t+=1
    for i in range(S):
        vidg.append(0)
        vidg[t] = Label(report, text = str(report_S[i]),width = 3, height=1,bg='green',fg='black',font='arial 10')
        vidg[t].grid(row = i+2, column = 100)
        t+=1
    for i in range(M):
        vidg.append(0)
        vidg[t] = Label(report, text = str(report_M[i]),width = 3, height=1,bg='green',fg='black',font='arial 10')
        vidg[t].grid(row = 100, column = i+2)
        t+=1
    
def finsh_window(array_price):
    """Функция для создания финального окна"""
    global arrP_vid, arrP
    global arrS, arrM
    global S_new, M_new
    global arrRes
    for i in range(S):
        for j in range(M):
            arrP[i][j] = arrP_vid[i][j].get()
            if (arrP[i][j].isdecimal() == False) or int(arrP[i][j])<0:
                info_2 = Toplevel()
                info_2.title("Некорректный ввод")
                info_2.geometry("700x300")
                my_text="""
                !!!Некорректный ввод!!!
                В данные пробелы можно вводить только ЦЕЛЫЕ числа,
                без каких-либо дополнительных символов
                (в том числе и пробелы, знаки препинания и
                математические знаки)

                Также все целые числа должны быть только положительными!
                Иначе теряется логика задачи.

                Допускается 0."""
                inf2 = Label(info_2,justify = LEFT, text = my_text,width = 75, height=15,bg='white',fg='black',font='arial 10')
                inf2.grid(row = 1, column = 1)
                return
    print('Цены: ', arrP)
    #start_time = time.time()
    arrRes = decision_func(arrS, arrM, arrP, arrRes, S_new, M_new)
    #print("--- %s seconds ---" % (time.time() - start_time))
    print('Ответ: ', arrRes)
    Result = Toplevel()
    Result.title("Результат")
    Result.geometry("700x500")
    otvet = 0
    vidg = []
    t=0
    for i in range(S):
        for j in range(M):
            if arrRes[i][j] != '-' and arrRes[i][j] != 0:
                otvet += int(arrRes[i][j])*int(arrP[i][j])
                vidg.append(0)
                my_text='Нужно отправить из '+str(i+1)+' склада в '+str(j+1)+' магазин '+str(arrRes[i][j])+' ед. товара'
                vidg[t]= Label(Result, text = my_text,width = 75, height=1,bg='white',fg='black',font='arial 10')  
                vidg[t].grid(row = t+1, column = 1)
                t+=1
    if S!=S_new:
        for i in range(M):
            if arrRes[-1][i]!= '-' and arrRes[-1][i]!= 0:
                vidg.append(0)
                my_text = 'Долг: в '+str(i+1)+' магазин - '+str(arrRes[-1][i])+' ед. товара'
                vidg[t] = Label(Result, text = my_text,width = 75, height=1,bg='white',fg='black',font='arial 10')
                vidg[t].grid(row = t+1, column = 1, columnspan = 3)
                t+=1
    if M!=M_new:
        for i in range(S):
            if arrRes[i][-1]!= '-' and arrRes[i][-1]!= 0:
                vidg.append(0)
                my_text = 'Остаток: в '+str(i+1)+' складе - '+str(arrRes[i][-1])+' ед. товара'
                vidg[t] = Label(Result, text = my_text,width = 75, height=1,bg='white',fg='black',font='arial 10')
                vidg[t].grid(row = t+1, column = 1, columnspan = 1)
                t+=1
    vidg.append(0)
    my_text = 'ИТОГО: '+str(otvet)+' ден. ед. для перевоза продукции'
    vidg[t] = Label(Result, text = my_text,width = 45, height=2,bg='white',fg='red',font='arial 14')
    vidg[t].grid(row = t+1, column = 1, columnspan = 1)
    t+=1
    fexid = Button(Result, text = 'Exit', width  = 10, height = 2, bg = 'orange', fg = 'black', font = 'arial 10')
    fexid.grid(row = t+1, column = 1, columnspan = 1)
    fexid.bind("<Button-1>", sys.exit)
    t+=1
    fot = Button(Result, text = 'Подробнее', width  = 10, height = 2, bg = 'green', fg = 'black', font = 'arial 10')
    fot.grid(row = t+1, column = 1, columnspan = 1)
    fot.bind("<Button-1>", my_report)
    
def func_price(okno_zadach):
    """Функция для заполнения матрицы цен"""
    global arrS, report_S
    global arrM, report_M
    global arrP
    global arrP_vid
    global arrRes
    global S, M
    global S_new, M_new
    S_new = S
    M_new = M
    arrS = []
    arrM = []
    _sumM = 0
    _sumS = 0
    arrP_vid = [[i for i in range(M)] for x in range(S)]
    for i in range(M):
        x = MX[i].get()
        if (x.isdecimal() == False) or (int(x)<1):
            info_2 = Toplevel()
            info_2.title("Некорректный ввод")
            info_2.geometry("700x300")
            my_text="""
                !!!Некорректный ввод!!!
                В данные пробелы можно вводить только ЦЕЛЫЕ числа, без каких-либо
                дополнительных символов(в том числе и пробелы, знаки препинания и
                математические знаки)

                Также все целые числа должны быть только положительными!
                Иначе теряется логика задачи.

                Не стоить ставить "0". Если в условиях есть этот 0, то:
                1. Закройте окно "Постановка задачи"
                2. Уменьшете нужную шкалу на кол-во тех самых нулей
                3. В последующих окнах не учитывайте
                что существуют данные склады/магазины"""
            inf2 = Label(info_2,padx = 2,justify = LEFT, text = my_text,width = 75, height=15,bg='white',fg='black',font='arial 10')
            inf2.grid(row = 1, column = 1)
            return
        arrM.append(x)
        _sumM += int(x)
    for i in range(S):
        x = SX[i].get()
        if (x.isdecimal() == False) or int(x)<1:
            info_2 = Toplevel()
            info_2.title("Некорректный ввод")
            info_2.geometry("700x300")
            my_text="""
                !!!Некорректный ввод!!!
                В данные пробелы можно вводить только ЦЕЛЫЕ числа, без каких-либо
                дополнительных символов(в том числе и пробелы, знаки препинания и
                математические знаки)

                Также все целые числа должны быть только положительными!
                Иначе теряется логика задачи.

                Не стоить ставить "0". Если в условиях есть этот 0, то:
                1. Закройте окно "Постановка задачи"
                2. Уменьшете нужную шкалу на кол-во тех самых нулей
                3. В последующих окнах не учитывайте
                что существуют данные склады/магазины"""
            inf2 = Label(info_2,justify = LEFT, text = my_text,width = 75, height=15,bg='white',fg='black',font='arial 10')
            inf2.grid(row = 1, column = 1)
            return
        arrS.append(x)
        _sumS += int(x)
    report_S = list(arrS)
    report_M = list(arrM)
    print("Необходимо: ", arrM, " ", _sumM)
    print("Имеется: ", arrS, " ", _sumS)
    array_price = Toplevel()
    array_price.title("Стоимость перевозки")
    array_price.geometry("400x400")
    for i in range(S):
        my_text = "скл"+str(i+1)
        _inf = Label(array_price, text = my_text,width = 5, height=1,bg='white',fg='black',font='arial 10')
        _inf.grid(row = i+2, column = 1)
    for i in range(M):
        my_text = "м"+str(i+1)
        _inf = Label(array_price, text = my_text,width = 3, height=1,bg='white',fg='black',font='arial 10')
        _inf.grid(row = 1, column = i+2)
    for i in range(S):
        for j in range(M):
            arrP_vid[i][j] = Entry(array_price,width = 3)
            arrP_vid[i][j].grid(row=i+2, column = j+2)
    if _sumM > _sumS:
        arrS.append(_sumM - _sumS)
        arrP = [[M-i-1 for i in range(M)] for x in range(S+1)]
        S_new += 1
        arrRes = [['?' for i in range(M)] for x in range(S+1)]
    elif _sumM < _sumS:
        arrM.append(_sumS - _sumM)
        arrP = [[M-i for i in range(M+1)] for x in range(S)]
        M_new += 1
        arrRes = [['?' for i in range(M+1)] for x in range(S)]
    else:
        arrP = [[M-i-1 for i in range(M)] for x in range(S)]
        arrRes = [['?' for i in range(M)] for x in range(S)]
    _back_2 = Button(array_price, text = 'Exit', width  = 8, height = 3, bg = 'orange', fg = 'black', font = 'arial 10')
    _back_2.grid(row = 13, column = 1, columnspan = 3)
    _back_2.bind("<Button-1>", sys.exit)
    _resh = Button(array_price, text = 'Решить', width  = 8, height = 3, bg = 'green', fg = 'black', font = 'arial 10')
    _resh.grid(row = 13, column = 7, columnspan = 3)
    _resh.bind("<Button-1>", finsh_window)

def window_info(root):
    """Функция для вывода информации"""
    info_one = Toplevel()
    info_one.title("Информация о задаче")
    info_one.geometry("700x400")
    my_text ="""Транспортная задача (задача Монжа-Канторовича) -
        задача об оптимальном плане перевозок однородного продукта из однор.
        пунктов наличия в однородные пункты потребления на однородных
        транспортных средствах со статичными данными и
        линеарном подходе.

         В данном приложении рассматривается лишь один тип такой задачи:
        1. Расчет производится для минимизации затрат на перевоз.
        2. Первичный опорный план находится по методу Северо-Заподного угла
        3. Метод улучшения опорного плана: Метод потенциалов

        Класс сложности данной задачи - класс P, который позволяет точно оценить
        сложность алгоритмов для решения задачи.
        Алгоритм в данном приложении является точным.

        Все несбалансированные задачи приводятся к сбалансированной и в ответе
        указываются остатки продукции на складах или долги для магазинов."""
    info_A = Label(info_one, text = my_text,width = 75, height=20,bg='white',fg='black',font='arial 10')
    info_A.grid(row = 1, column =1)
    
def in_sl_okno(root):
    """Функция для заполнения необходимого и имеющегося товара"""
    global S
    global M
    global MX
    global SX
    global scale1, scale2
    S = scale2.get()
    M = scale1.get()
    print("Склады: ",S, ' Магазины: ', M)
    okno_zadach = Toplevel()
    okno_zadach.title("Постановка задачи")
    okno_zadach.geometry("700x150")
    sclad_2 = Label(okno_zadach, text = 'Кол-во имеющегося продукта на складах: ', width=40,height=1,bg='white',fg='black',font='arial 10')
    magazin_2 = Label(okno_zadach, text = 'Кол-во необходимого продукта в магазины: ', width=40,height=1,bg='white',fg='black',font='arial 10')
    magazin_2.grid(row = 1, column = 1)
    sclad_2.grid(row = 2, column = 1)
    _back_1 = Button(okno_zadach, text = 'Exit', width  = 8, height = 3, bg = 'orange', fg = 'black', font = 'arial 10')
    _dalee = Button(okno_zadach, text = 'Далее', width  = 8, height = 3, bg = 'green', fg = 'black', font = 'arial 10')
    _back_1.grid(row = 4, column = 1)
    _dalee.grid(row = 4, column = 8, columnspan = 3)
    _back_1.bind("<Button-1>", sys.exit)
    _dalee.bind("<Button-1>", func_price)
    MX = [0]*M
    SX = [0]*S
    for i in range(M):
        MX[i] = Entry(okno_zadach,width = 3)
        MX[i].grid(row = 1, column = i+2)
    for i in range(S):
        SX[i] = Entry(okno_zadach,width = 3)
        SX[i].grid(row = 2, column = i+2)

def main():
    global scale1, scale2
    root = Tk()
    root.title("Транспортная задача на Python")
    root.geometry("450x300")
    magazins = Label(root, text = 'Кол-во магазинов: ', width=25,height=3,bg='white',fg='black',font='arial 10')
    sclads = Label(root, text = 'Кол-во Складов: ', width=25,height=3,bg='white',fg='black',font='arial 10')
    but_ok = Button(root, text = 'Ok', width  = 10, height = 3, bg = 'green', fg = 'black', font = 'arial 10')
    _exit = Button(root, text = 'Exit', width  = 10, height = 3, bg = 'orange', fg = 'black', font = 'arial 10')
    scale1 = Scale(root, orient=HORIZONTAL, length=200 , from_ =1, to = 10, tickinterval=1, resolution = 1)
    scale2 = Scale(root, orient=HORIZONTAL, length=200 , from_ =1, to = 10, tickinterval=1, resolution = 1)
    scale1.grid(row = 2, column = 1)
    scale2.grid(row = 2, column = 2)
    magazins.grid(row = 1, column = 1)
    sclads.grid(row = 1, column = 2)
    but_ok.grid(row = 4, column = 2)
    _exit.grid(row = 4, column = 1)
    but_ok.bind("<Button-1>", in_sl_okno)
    _exit.bind("<Button-1>", sys.exit)
    _info = Button(root, text = 'О задаче', width  = 16, height = 3, bg = 'gray', fg = 'black', font = 'arial 10')
    _info.grid(row = 5, column=1, columnspan = 2)
    _info.bind("<Button-1>", window_info)
    root.mainloop()

main()
