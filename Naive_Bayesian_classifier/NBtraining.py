import math as m
import csv
import sys

def training_naive(count_doc_ = None, Quality = False):
    TRAIN_CSV_PATH = "D:\\Uchoba\\Kocheshkov\\Curs\\Data\\data_train.csv"
    NAIVE_CSV_PATH = "D:\\Uchoba\\Kocheshkov\\Curs\\Data\\model_naive.csv"
    TEST_TIME_CSV_PATH = "D:\\Uchoba\\Kocheshkov\\Curs\\Data\\test_time.csv"
    TOKENS = {}
    CLASSES = []
    COUNT_DOCUMENTS = 0
    if (count_doc_ is None) or Quality:
        train_file = open(TRAIN_CSV_PATH, "r")
    else:
        train_file = open(TEST_TIME_CSV_PATH, "r")
    reader = csv.reader(train_file, delimiter = ',')
    for document in reader:
        if len(document)<2:
            continue
        if count_doc_ == 0:
            break
        elif count_doc_ is not None:
            count_doc_ -= 1
        COUNT_DOCUMENTS +=1
        _class, tokens = document[0], document[1:]
        if _class not in CLASSES:
            CLASSES.append(_class)
        for token in tokens:
            if token in TOKENS:
                if _class in TOKENS[token]:
                    TOKENS[token][_class] += 1
                else:
                    TOKENS[token][_class] = 1
            else:
                TOKENS[token] = {_class : 1}
    train_file.close()

    model = open(NAIVE_CSV_PATH, "w") 
    writer = csv.writer(model, delimiter = ',')
    writer.writerow([COUNT_DOCUMENTS]+CLASSES)
    for token in TOKENS.keys():
        word_tf = []
        for _class in CLASSES:
            if _class in TOKENS[token]:
                word_tf.append(TOKENS[token][_class]+1)
            else:
                word_tf.append(1)
        writer.writerow([token]+word_tf)
    model.close()

if __name__ == "__main__":
    if len(sys.argv) == 1:
        training_naive()
    elif len(sys.argv) == 2:
        training_naive(int(sys.argv[1]))
    elif len(sys.argv) == 3:
        training_naive(int(sys.argv[1]), True)
    else:
        print("Parametrs error!")
        sys.exit(1)