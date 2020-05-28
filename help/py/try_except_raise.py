def not_zero(num):
    try:
        if num == 0:
            raise ValueError('参数错误')
        return num
    except Exception as e:
        print(e)
 
try:
    1/0
except Exception as e:
    print(e) 

not_zero(0)

str1 = 'hello world'
try:
    int(str1)
except IndexError as e:
    print(e)
except KeyError as e:
    print(e)
except ValueError as e:
    print(e)
else:
    print('try内没有异常')
finally:
    print('无论异常与否,都会执行我')
