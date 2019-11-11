// check the dot output in http://www.webgraphviz.com/

unsigned euclid(unsigned a, unsigned b) {
	while (a != b)
		if (a > b)
			a = a - b;
		else
			b = b - a;
	return a;
}

int main(){
	int ret;
	ret =  euclid(1,2);
	return ret;
}
