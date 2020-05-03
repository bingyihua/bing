import paramiko
def ftpget(args):
	transport = paramiko.Transport(('192.168.70.11', 22))
	transport.connect(username='mcbadm', password='McbUnix_2017')
	sftp = paramiko.SFTPClient.from_transport(transport)
	aa=sftp.get('/opt/mcb/dps1/arch/incoming/020/'+args, 'E:\\soft\\'+args)
	print(aa)


def ftpput(args):
	transport = paramiko.Transport(('192.168.70.11', 22))
	transport.connect(username='mcbadm', password='McbUnix_2017')
	sftp = paramiko.SFTPClient.from_transport(transport)
	bb=sftp.get( 'D:\\'+args,'/home/mcbadm/cyb'+args)
ftpget ("cps1_gsmspdba_add_KR-20180418-10142803.sql")
