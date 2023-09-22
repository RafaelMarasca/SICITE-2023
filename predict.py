from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import accuracy_score
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns


df = pd.read_csv('data/features/features.csv')
df = df.sample(frac = 1)
df.head()

X = df.drop(['class'], axis=1)

y_label = df['class']

encoder = LabelEncoder()

encoder.fit(y_label)
y = encoder.transform(y_label)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 42, stratify=y)

scaler = StandardScaler()

X_train = scaler.fit_transform(X_train)

X_test = scaler.transform(X_test)


model = tf.keras.models.load_model('modelo.keras')

model.evaluate(X_test,  y_test)

y_pred = model.predict(X_test)
y_pred = y_pred.argmax(1)

print('Accuracy'. format(accuracy_score(y_test, y_pred)))
print(classification_report(y_test, y_pred,))

cm = confusion_matrix(y_test, y_pred)

class_names = ['blues', 'classical', 'country', 'disco', 'hiphop', 'jazz', 'metal', 'pop', 'raggae', 'rock']

fig = plt.figure()
ax= plt.subplot()
sns.color_palette("flare", as_cmap=True)
sns.heatmap(cm, annot=True, ax = ax, fmt = 'g')

ax.set_xlabel('Inferido', fontsize=30)
ax.xaxis.set_label_position('bottom')
plt.xticks(rotation=90)
ax.xaxis.set_ticklabels(class_names, fontsize = 20)
ax.xaxis.tick_bottom()

ax.set_ylabel('Real', fontsize=30)
ax.yaxis.set_ticklabels(class_names, fontsize = 20)
plt.yticks(rotation=0)

plt.show()
