
#reduce()函数也接收一个函数function, 和一个list。但reduce()传入的函数必须接收两个参数，reduce()对list的每个元素反复调用函数function, 并返回最终结果值
def is_contain_s(s):
    if 'E' in s:
        return True
    else:
        return False
    
result = filter(is_contain_s, ['sTEst', 'abc', 'str', ' ', 'END'])
print(list(result))
# 输出内容：
# ['sTEst', 'END']



#map()是 Python 内置的高阶函数，它接收一个函数function 和一个 list，并通过把函数 function 依次作用在 list 的每个元素上，得到一个新的 list 并返回
def format_name(s):
    return s.capitalize()
result = map(format_name, ['adam', 'LISA', 'barT'])
print(list(result))

# 输出内容：
# ['Adam', 'Lisa', 'Bart']



from functools import reduce
#reduce()函数也接收一个函数function, 和一个list。但reduce()传入的函数必须接收两个参数，reduce()对list的每个元素反复调用函数function, 并返回最终结果值。
def f(x, y):
    return x + y

result = reduce(f, [1, 3, 5, 7, 9])
print(result)

# 输出内容：
# 25
