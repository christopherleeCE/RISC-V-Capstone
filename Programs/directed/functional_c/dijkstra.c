/*
DIJKSTRA's ALGORITHM (Adjacency Matrix Version) -
A classic algorithm for pathfinding, I learned of this from communication networks. This is used
in routing, video games, navigation, and more. This version uses an adjacency matrix to represent
the graph. - Edgar G.

*/

#include <limits.h>
#include "base.h"
#include "drysoup.h"

#define INF INT_MAX //infinity represented by largest number possible
#define N 7 //number of nodes in graph
#define SRC 3 //source node in graph

//function prototype
void dijkstra(int map[N][N], int dist_arr[N], int visited[N]);

//MAIN
int main()
{
    //SETUP
    int dist_arr[N]; //to hold the distance from source node to every other node
    int visited[N] = {0}; //to track the nodes that have been traveled

    //adjency matrix - row represents a node, column represents the weights of the edges
    //in other words, this represents our map!
    int map[N][N] =
    {
        {0, 0, 3, 4, 4, 0, 0},  //A
        {0, 0, 2, 0, 0, 2, 0},  //B
        {3, 2, 0, 0, 4, 5, 5},  //C
        {4, 0, 0, 0, 2, 0, 0},  //D
        {4, 0, 4, 2, 0, 0, 5},  //E
        {0, 2, 5, 0, 0, 0, 5},  //F
        {0, 0, 5, 0, 5, 5, 0}   //G
    };

    //distance array to hold the value from source node to all other nodes
    //distances are initialized to a very large number
    for(int i = 0; i <= N-1; i++)
        if(i == SRC)
            dist_arr[i] = 0;
        else
            dist_arr[i] = INF;

    //update the distance array
    dijkstra(map, dist_arr, visited);

    //return the distance array
    return tb_return(
        dist_arr[0],
        pack_ptr((uint32_t*)dist_arr, N, false)
    );
}


//DIJKSTRA'S ALGORITHM
void dijkstra(int map[N][N], int dist_arr[N], int visited[N])
{
    int current_node = SRC; //start by setting source node as current node
    int dist_from_src = 0; //used to keep track of total distance from source node

    for(int i = 0; i <= N-1; i++) //we need to visit all the nodes in the map
    {
        //UPDATE THE DISTANCE ARRAY
        //from the current node, we'll check the distance to the other nodes
        for(int other_node = 0; other_node <= N-1; other_node++)
        {
            //variable to hold distance from current node to other node (for convenience)
            int dist_to_neighbor = map[current_node][other_node];

            //check if the other node is an adjacent node that have not been visited yet
            if(dist_to_neighbor > 0 && !visited[other_node])

                //update the existing distance from the source node to the other node if the path
                //via the current node is shorter: this is known as "relaxing" the other node
                if(dist_from_src + dist_to_neighbor < dist_arr[other_node])

                    dist_arr[other_node] = dist_from_src + dist_to_neighbor;

        }

        //MARK CURRENT NODE AS TRAVELED
        visited[current_node] = 1;

        //FIND THE NEXT NODE
        //determine the unvisited node with the shortest distance to the source node
        int shortest_to_src = INF;
        for(int next_node = 0; next_node <= N-1; next_node++)
            if(!visited[next_node] && dist_arr[next_node] < shortest_to_src)
            {
                current_node = next_node;
                shortest_to_src = dist_arr[next_node];
            }

        //UPDATE DISTANCE FROM SOURCE TO NEXT NODE
        dist_from_src = shortest_to_src;
        
    }
}