dust = 120

print(dust > 150)
print(dust > 100)

if dust > 150:
    print("매우 나쁨")
elif dust > 100:
    print("나쁨")
elif dust > 80:
    print("보통")
else:
    print("좋음")