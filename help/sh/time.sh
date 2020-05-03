for i in 60 61 62 63 64 64 65 70 71 72 74;
do
#	echo "192.168.158.1$i"
	ssh -o StrictHostKeyChecking=no 192.168.158.1$i  "date \"+%Y-%m-%d %H:%M:%S\""
done
