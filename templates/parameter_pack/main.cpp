#include <iostream>
#include <typeinfo>

#include <string>
#include <vector>

void print_type_impl() // for no type given
{
	std::cout << "========" << "\n";
}

template<typename T, typename ...TArgs>
void print_type_impl(T&& t, TArgs&& ...Fargs)
{
	std::cout << typeid(T).name() << "\n";
	print_type_impl(std::forward<TArgs>(Fargs)...);
}

template<typename ...TArgs>
struct count {
	static constexpr size_t size = sizeof ... (TArgs);
};

template<typename ...TArgs>
void print_type(TArgs&& ...Fargs) // for no type given
{
	std::cout << "Totol args: " << count<TArgs...>::size << "\n";
	print_type_impl(std::forward<TArgs>(Fargs)...);

}
int main(int argc, char** argv)
{
	print_type();
	print_type(1, true, std::string(), std::vector<int>());
	return 0;
}