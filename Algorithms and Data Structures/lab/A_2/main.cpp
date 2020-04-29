#include <cstdio>
#include <vector>

using namespace std;


void find_res(int i, int j, vector<vector<pair<pair<int, int>, pair<int, bool> > > > &graf, bool &is_good, vector<pair<int, int > > &res){
    graf[i][j].second.second = true;
    if(graf[i][j].second.first == 0){
        is_good = true;
        res.push_back(make_pair(i, j));
    }
    if(!is_good){
        for(unsigned int k=0; k<graf[graf[i][j].second.first].size(); k++){
            if(is_good){
                break;
            }else{
                if(graf[graf[i][j].second.first][k].second.second == false){
                    find_res(graf[i][j].second.first, k, graf, is_good, res);
                }
            }
        }
        if(is_good){
            res.push_back(make_pair(i, j));
        }
    }
}


int main()
{
    int n, l, m, r;
    vector<vector<pair<pair<int, int>, pair<int, bool> > > > graf(10001);
    vector<pair<int, int > > res;
    bool is_good = false;

    scanf("%d",&n);
    for(int i=0; i<n; i++){
        scanf("%d",&l);
        scanf("%d",&m);
        scanf("%d",&r);
        graf[l].push_back(make_pair(make_pair(l, m), make_pair(r, false)));
    }

    for(unsigned int i=0; i<graf[0].size(); i++){

        find_res(0, i, graf, is_good, res);
        if(is_good){
            break;
        }
    }

    if(is_good){
        printf("%lu\n", res.size());
        for(int i=res.size()-1; i>=0; i--){
            printf("%d %d %d\n", graf[res[i].first][res[i].second].first.first, graf[res[i].first][res[i].second].first.second, graf[res[i].first][res[i].second].second.first);
        }
    }else{
        printf("BRAK");
    }

    return 0;
}
