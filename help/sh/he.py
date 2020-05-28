i=0
while 1:
    i+=1
    print(i)
    aa=[n  for n in [j[:i] for j in ["aaabc","aab","aaa"] if [j[:i] for j in ["aaabc","aab","aaa"].count(j[:i])>1]
    if i==5:
        break
print(aa)
