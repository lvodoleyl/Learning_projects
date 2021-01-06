#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>

int main(void)
{
    int i,j,k,m;          // ��������
    int town[10][10];     // ������ ����� ��������
    double fer[10][10];   // ������� �� �������
    int tabu[10];         // ������ ��� ����������� ������������ �������
    int p[11];            // ������������ ���� � ��������
    double zn;            // ����������� �����������
    double ver[10];       // ����������� ��������� �������
    double delta;         // ��������� �������� �� �������
    int Q=0;              // ����������� ������ ��������
    int res=0;            // ���������
    int st_0;             // ����� � ��������
    int st_1;             // ����������� ����� � ��������
    int random;           // ������, ������������ ������
    int len;              // ����� ���� � ��������
    srand((unsigned)time(NULL));
    for(i=0;i<10;i++)     //���� ����� ����� � ���������(1) ������� ��������
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
    Q=(int)(Q/9);          // ���������� ������������ ��������
    for(k=0, st_1=0;k<30;k++,st_1++)    // ������ �������� � ������ ��������
    {
        len=0;
        for (i=0;i<10;i++) tabu[i]=0;
        st_0=st_1%10;
        p[0]=st_0;
        p[10]=st_0;
        tabu[st_0]=1;
        for (i=0;i<9;i++)  // �������� ����� ��������
        {
            for(m=0;m<10;m++) ver[m]=0.0;  // ��������� �����������
            zn=0.0;
            for(m=0;m<10;m++)
            {
                if (tabu[m]==0) zn+=(double)fer[st_0][m]/(double)town[st_0][m];
            }
            for(m=0;m<10;m++)
            {
                if (tabu[m]==0) ver[m]=(((double)fer[st_0][m]/(double)town[st_0][m])*100)/zn;
            }
            for(m=1;m<10;m++) ver[m]+=ver[m-1];  // ������������ ������� ����������� 
            random=rand()%100;                   // ������ ���� ����
            if ((random>=0)&&(random<ver[0])) j=0;
            else
            {
                for(j=1;j<10;j++)
                {
                    if ((random>=ver[j-1])&&(random<ver[j])) break;
                }
            }
            len+=town[st_0][j];                  // ���������� ����� ������ � ����� ����� ����
            p[i+1]=j;                            // ���������� ������� ����
            st_0=j;                              // ����������� ������ ������������ ������
            tabu[j]=1;                           // ���� ���� �� ����� ���������� �����
        }
        len+=town[st_0][p[10]];                  // ������� � ������ ����
        if (len<res) res=len;                    // �������� �� ���������� ��������
        delta=(double)Q/(double)len;             // ���������� ��������� ��������
        for(i=0;i<10;i++)                        // ���������� ������� ��������
        {
            fer[p[i]][p[i+1]]+=delta;
            fer[p[i+1]][p[i]]+=delta;
        }
        printf("%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d    len= %d\n", p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8],p[9],p[10],len);
    }
    printf("Otvet: %d\n", res);
    return 0;
}