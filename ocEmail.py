import smtplib
import sys,os
from email.mime.image import MIMEImage
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

#========Get user credentials================================
server =smtplib.SMTP('smtp.gmail.com',587)
emailUser = "openshiftbot"
emailPass = os.environ['EMAIL_PASS']

#========Send email to self=====================================
def notifyMe():
    #login to email server
    server =smtplib.SMTP('smtp.gmail.com',587)
    server.ehlo()
    server.starttls()
    server.ehlo()
    server.login(emailUser,emailPass)

    #write subject line
    msg = MIMEMultipart()
    msg['Subject'] = "Style-{} Delivery!".format(sys.argv[4])
    msg['From'] = emailUser
    tgt = sys.argv[2]
    msg['To'] = tgt
    
    #write message
    tag = sys.argv[4]
    timeTaken = sys.argv[6]
    text = MIMEText("Style-{} finished after {} s. Attached is the output image! ".format(tag,timeTaken))
    msg.attach(text)
    
    #attach images
    f = open("output.jpg","rb")
    img = MIMEImage(f.read(),name="output.jpg")
    f.close()
    msg.attach(img)

    #send message
    server.sendmail(emailUser, tgt, msg.as_string())
    server.quit()

notifyMe()
