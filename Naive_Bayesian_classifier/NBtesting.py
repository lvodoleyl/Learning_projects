import math as m
import csv
import sys

def testing_naive(count_doc_ = None):
    TEST_CSV_PATH = "D:\\Uchoba\\Kocheshkov\\Curs\\Data\\data_test.csv"
    NAIVE_CSV_PATH = "D:\\Uchoba\\Kocheshkov\\Curs\\Data\\model_naive.csv"
    TEST_TIME_CSV_PATH = "D:\\Uchoba\\Kocheshkov\\Curs\\Data\\test_time.csv"
    CLASSES = []
    TOKENS = {}
    PROBABILITY = {}
    model = open(NAIVE_CSV_PATH, "r") 
    reader = csv.reader(model)
    while True:
        _class = next(reader)
        if _class != []:
            break
    _, CLASSES = int(_class[0]), _class[1:]
    for token in reader:
        if token == []:
            continue
        TOKENS[token[0]] = [int(item) for item in token[1:]]
    model.close()
    if count_doc_ is None:
        test_data = open(TEST_CSV_PATH, "r") 
    else:
        test_data = open(TEST_TIME_CSV_PATH, "r") 
    reader = csv.reader(test_data, delimiter = ',')
    for test in reader:
        if test == []:
            continue
        if count_doc_ == 0:
            break
        elif count_doc_ is not None:
            count_doc_ -= 1
        test = list(test)
        for _class in CLASSES:
            PROBABILITY[_class] = 0
        for token in test:
            if token in TOKENS:
                for num in range(len(CLASSES)):
                    PROBABILITY[CLASSES[num]] += m.log2((TOKENS[token][num] / sum(TOKENS[token])) + 1)
        c, res = "", 0
        for _class in PROBABILITY:
            if PROBABILITY[_class] > res:
                c, res = _class, PROBABILITY[_class]
        print(c)
    test_data.close()

if __name__ == "__main__":
    if len(sys.argv) == 1:
        testing_naive()
    elif len(sys.argv) == 2:
        testing_naive(int(sys.argv[1]))
    else:
        print("Parametrs error!")
        sys.exit(1)
