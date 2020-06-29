library(dplyr)

train_set<-read.table("train/X_train.txt")
train_label<-read.table("train/y_train.txt")
train_subject<-read.table("train/subject_train.txt")

test_set<-read.table("test/X_test.txt")
test_label<-read.table("test/y_test.txt")
test_subject<-read.table("test/subject_test.txt")


X_mer<-rbind(train_set,test_set)
y_mer<-rbind(train_label,test_label)
subject<-rbind(train_subject,test_subject)

y_mer[,1]<-gsub("1","WALKING",y_mer[,1])
y_mer[,1]<-gsub("2","WALKING_UPSTAIRS",y_mer[,1])
y_mer[,1]<-gsub("3","WALKING_DOWNSTAIRS",y_mer[,1])
y_mer[,1]<-gsub("4","SITTING",y_mer[,1])
y_mer[,1]<-gsub("5","STANDING",y_mer[,1])
y_mer[,1]<-gsub("6","LAYING",y_mer[,1])

X_means<-rowMeans(X_mer)
X_std<- apply(X_mer,1, sd)
mer_total<-cbind(X_means,X_std,y_mer,subject)
names(mer_total)<- c("X_mean","X_std","activity","subject")
set<-mer_total%>%group_by(activity,subject)%>%summarise(mean=mean(X_mean))
write.table(set,"tidy_set.txt",row.names = FALSE)
