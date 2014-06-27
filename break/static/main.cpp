#include <ncurses.h>
#include <ctime>
#include <random>

using namespace std;

int main() {
	srand(time(0));
	
	initscr();
	
	while (true) {
		clear();
		for (int y = 0; y < LINES; y++) {
			for (int x = 0; x < COLS; x++) {
				mvaddch(y,x,(char)(97 + rand()%26));
			}
		}
		refresh();
	}
	endwin();
}
