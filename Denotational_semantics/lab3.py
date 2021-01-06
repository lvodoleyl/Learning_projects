def F(digit):
    count = 0
    while digit>0:
        count = (2*count)+digit
        digit = digit//2
    return count

#MainFunction
n = int(input())
for i in range(0, n, 1):
    print(F(i))

if F(3)==1:
    print(2)
