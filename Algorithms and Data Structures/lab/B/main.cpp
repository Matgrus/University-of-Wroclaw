#include <iostream>

using namespace std;

pair<long long, pair<int, int > > del_max(pair<long long, pair<int, int > > heap[],int heap_end, pair<long long,long long> pom){
    pair<long long, pair<int, int > > res=heap[0];
    if(res.second.second>res.second.first){
        heap[0]=make_pair((long long)res.second.first*(long long)(res.second.second-1),make_pair(res.second.first,res.second.second-1));
    }else{
        heap[0]=make_pair(pom.first*pom.second,pom);
    }
    int j=0;
    while(j<heap_end-2){
        if(2*j+2<heap_end){
            if(heap[2*j+1].first < heap[2*j+2].first){
                if(heap[j].first >= heap[2*j+2].first){
                    break;
                }else{
                    pair<long long, pair<int, int > > el=heap[j];
                    heap[j]=heap[2*j+2];
                    heap[2*j+2]=el;
                    j=2*j+2;
                }
            }else{
                if(heap[j].first >= heap[2*j+1].first){
                    break;
                }else{
                    pair<long long, pair<int, int > > el=heap[j];
                    heap[j]=heap[2*j+1];
                    heap[2*j+1]=el;
                    j=2*j+1;
                }
            }
        }else if(2*j+1<heap_end){
            if(heap[j].first >= heap[2*j+1].first){
                break;
            }else{
                pair<long long, pair<int, int > > el=heap[j];
                heap[j]=heap[2*j+1];
                heap[2*j+1]=el;
                j=2*j+1;
            }
        }else{
            break;
        }
    }
    return res;
}


int main()
{
    int n,k,m;
    scanf("%d",&n);
    scanf("%d",&k);
    if(n>500000){
        m=500000;
    }else{
        m=n;
    }
    pair<long long, pair<int, int > > *heap=new pair<long long, pair<int, int > > [m];
    pair<long long,long long> pom=make_pair(n-m,n);

    for(long long i=0;i<m;i++){
        heap[i]=make_pair((n-i)*n, make_pair(n-i,n));
    }

    long long prev = 0;
    while(k>0){
        pair<long long, pair<int, int > > res = del_max(heap, m, pom);
        if(res.second.second==res.second.first){
            pom.first-=1;
        }
        if(res.first!=prev){
            printf("%lld\n",res.first);
            k-=1;
            prev=res.first;
        }
    }


    delete[] heap;

    return 0;
}
