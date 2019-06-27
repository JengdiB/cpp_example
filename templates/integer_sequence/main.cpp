#include <iostream>

#include <tuple>
#include <type_traits>
#include <utility>

template <typename T>
void function_impl(T&& t)
{
	std::cout << typeid(T).name() << ": " << std::is_integral_v<std::decay<T>::type>  << std::endl;
	//function_impl(std::forward<T>(t), std::integral_constant<bool, std::is_integral<T>::value>());
}
template <typename T>
void function_impl(T&& t, std::true_type)
{
	std::cout << "int: " << typeid(t).name() << "\n";
}

template <typename T>
void function_impl(T&& t, std::false_type)
{
	std::cout << "not-int: " << typeid(t).name() << "\n";
}

void function() // for umpty unpack
{

}

template <typename T, typename ...TArgs>
void function(T&& t, TArgs&& ...Fargs)
{
	function_impl(std::forward<T>(t));
	function(std::forward<TArgs>(Fargs)...);
}



template <typename Tuple, size_t ...Is>
constexpr auto apply_impl(Tuple t, std::index_sequence<Is...>)
{
	return function(std::get<Is>(t)...);
}

template <typename Tuple>
constexpr auto apply(Tuple t)
{
	return apply_impl(t, std::make_index_sequence<std::tuple_size<Tuple>::value>{});
}

int main(int argc, char** argv)
{
	auto my_tuple = std::make_tuple(1, "const char*", true);

	apply(my_tuple);
	return 0;
}