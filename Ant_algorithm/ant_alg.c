#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>

int main(void)
{
    int i,j,k,m;          // счетчики
    int town[10][10];     // дороги между городами
    double fer[10][10];   // феромон на дорогах
    int tabu[10];         // массив для определения посещаемости городов
    int p[11];            // получающийся путь в итерации
    double zn;            // знаменатель вероятности
    double ver[10];       // вероятности посещения городов
    double delta;         // изменение феромона на дорогах
    int Q=0;              // коэффециент памяти феромона
    int res=0;            // результат
    int st_0;             // старт в итерации
    int st_1;             // приведенный старт в итерации
    int random;           // рандом, определяющий дорогу
    int len;              // длина пути в итерации
    srand((unsigned)time(NULL));
    for(i=0;i<10;i++)     //ввод длины дорог и обнуление(1) массива феромона
    {
        for(j=0;j<10;j++)
        {
            fer[i][j]=1.0;
            if (i==j) town[i][j]=0;
            else
            if (i>j) town[i][j]=town[j][i];
            else
            {
                printf("Enter the length of the road from %d to %d towns: ", i, j);
                scanf("%d", &town[i][j]);
                res+=town[i][j];
                Q+=town[i][j];
                if (town[i][j]<=0)
                {
                    printf("Error!\n");
                    exit(1);
                }
            }
        }
    }
    Q=(int)(Q/9);          // нахождение коэффициента феромона
    for(k=0, st_1=0;k<30;k++,st_1++)    // номера итераций и старта итерации
    {
        len=0;
        for (i=0;i<10;i++) tabu[i]=0;
        st_0=st_1%10;
        p[0]=st_0;
        p[10]=st_0;
        tabu[st_0]=1;
        for (i=0;i<9;i++)  // основной поиск маршрута
        {
            for(m=0;m<10;m++) ver[m]=0.0;  // зануление вероятности
            zn=0.0;
            for(m=0;m<10;m++)
            {
                if (tabu[m]==0) zn+=(double)fer[st_0][m]/(double)town[st_0][m];
            }
            for(m=0;m<10;m++)
            {
                if (tabu[m]==0) ver[m]=(((double)fer[st_0][m]/(double)town[st_0][m])*100)/zn;
            }
            for(m=1;m<10;m++) ver[m]+=ver[m-1];  // формирование отрезка вероятности 
            random=rand()%100;                   // рандом куда идти
            if ((random>=0)&&(random<ver[0])) j=0;
            else
            {
                for(j=1;j<10;j++)
                {
                    if ((random>=ver[j-1])&&(random<ver[j])) break;
                }
            }
            len+=town[st_0][j];                  // добавление длины дороги к общей длине пути
            p[i+1]=j;                            // заполнение массива пути
            st_0=j;                              // обозначение нового приведенного старта
            tabu[j]=1;                           // ввод табу на новый посещаемый город
        }
        len+=town[st_0][p[10]];                  // возврат в начало пути
        if (len<res) res=len;                    // проверка на короткость маршрута
        delta=(double)Q/(double)len;             // нахождение изменения феромона
        for(i=0;i<10;i++)                        // обновление массива феромона
        {
            fer[p[i]][p[i+1]]+=delta;
            fer[p[i+1]][p[i]]+=delta;
        }
        printf("%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d    len= %d\n", p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8],p[9],p[10],len);
    }
    printf("Otvet: %d\n", res);
    return 0;
}