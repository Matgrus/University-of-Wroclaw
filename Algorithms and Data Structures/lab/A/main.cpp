#include <iostream>

using namespace std;

long long dist(int a, int b, long long tab[], long long sum){
    long long dir1=tab[b]-tab[a];
    long long dir2 = sum-dir1;
    if(dir1<dir2){
        return dir1;
    }else{
        return dir2;
    }
}

int main()
{

    int n,m;
    long long res=0;
    scanf("%d",&n);
    long long *sum_tab=new long long [n+1];
    sum_tab[0]=0;
    for(int i=1;i<n+1;i++){
        scanf("%d",&m);
        sum_tab[i]= sum_tab[i-1]+m;
    }

    int counter=0;
    for(int i=0;i<n;i++){
        long long a= dist(0,i,sum_tab,sum_tab[n]);
        if(a>res){
            res=a;
            counter=i;
        }
    }

    int j;
    long long pom_sum;
    long long prev;
    for(int i=1;i<counter+1;i++){
        pom_sum=0;
        j=counter;
        prev=0;
        while(j<n){
            long long a= dist(i,j,sum_tab,sum_tab[n]);
            if(a<prev){
                break;
            }
            prev=a;
            if(a>pom_sum){
                if(a>res){
                    res=a;
                }
                pom_sum=a;
                counter=j;
            }
            j+=1;
        }
    }

    printf("%lld",res);
    delete[] sum_tab;

    return 0;
}
