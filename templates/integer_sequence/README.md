# std::integer_sequence

| Tool | Why |
|:-----|:----|
|std::tuple| to use std::integer_sequence to unpack std::tuple elements at compile time|
|std::make_tuple| a helper to create tuple|
|std::tuple_size| to get a size of elements of tuple at compile time|
|std::make_index_sequence|to generate std::index_sequence with use size of std::tuple as an argument|
|std::get| to get an element of tuple at a given index at compile time|
|std::index_sequence|a template class used for unpack template parameters. in this case, an index of tuple|
|std::forward|to forward what given in a template function to other function|
|std::decay|due to using universal reference and I don't know much about it. it need this to make std::is_integral work|
|std::is_integral||
|std::true_type||
|std::false_type||