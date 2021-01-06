module Perceptron  (createNN_class,
                    createNN_regr, 
                    random_weight,
                    train_nn,
                    test_nn,
                    complex_train,
                    quality_nn_class,
                    quality_nn_regr,
                    NN) where
import Prelude
import System.Random
import System.IO.Unsafe

-- нейронная сеть состоит из списка входных слоев и выходных
data NN = NN [InputLayer] [OutputLauer] deriving (Show)
-- входной слой состоит их чисел
data InputLayer = IL Double  deriving (Show)
-- выходной слой состоит из соответствующих весов, функции суммирования и активации
data OutputLauer = OL [Double] ([Double] -> [Double] -> Double) (Double -> Double)
-- опишем как будет печататься выходной слой
instance Show (OutputLauer) where
    show (OL a b c)
        | (c 200) == 1.0 = "<"++ (show a) ++"> stair"
        | otherwise = "<"++ (show a) ++"> reLU"

-- создание нейронной сети для бинарной классификации
createNN_class :: Int -> Int -> Maybe NN
createNN_class n m 
    | or [n < 1, m < 1] = Nothing 
    | otherwise = Just $ NN (createIL n) (createOL m n 1)

-- создание нейронной сети для регрессии
createNN_regr :: Int -> Int -> Maybe NN
createNN_regr n m 
    | or [n < 1,m < 1] = Nothing 
    | otherwise = Just $ NN (createIL n) (createOL m n 2)

-- инициализация входного слоя сети
createIL :: Int -> [InputLayer]
createIL 0 = []
createIL n = IL 0.0 : createIL (n-1)

-- инициализация выходного слоя сети
createOL :: Int -> Int -> Int -> [OutputLauer]
createOL 0 _ _ = []
createOL n m type_task
    | type_task == 1 = OL a sum_weight activ_class : createOL (n-1) m type_task
    | otherwise = OL a sum_weight activ_regr : createOL (n-1) m type_task
        where
            a = _count (m+1)  
            _count 0 = []
            _count r = 0.0 : _count (r-1)

-- функция (x1*w1 + x2*w2 + .. + xn*wn + w0)
sum_weight :: [Double] -> [Double] -> Double
sum_weight [] [m] = m 
sum_weight (a:[]) [b,w] = a*b + (sum_weight [] [w])
sum_weight (a:as) (b:bs) = a*b + (sum_weight as bs)

-- функция активации для классификации : ступенька
activ_class :: Double -> Double 
activ_class a 
    | a < 0 = - 1.0
    | otherwise = 1.0

-- функция активации для регрессии : Relu
activ_regr :: Double -> Double 
activ_regr a 
    | a < 0 = 0.0
    | otherwise = a 

-- инициализация весов в нейронной сети с помощью рандома
random_weight :: Maybe NN -> Maybe NN 
random_weight (Nothing) = Nothing
random_weight (Just(NN il ol)) = (Just(NN il (r_ol ol)))

-- вспомогательная функция для рандомизации
r_ol :: [OutputLauer] -> [OutputLauer]
r_ol [] = []
r_ol ((OL w s a):t1) = (OL w1 s a):(r_ol t1) 
    where
        w1 = rndm (length w)
        rndm 0 = [] 
        rndm n = (unsafePerformIO $ randomRIO(-1.0,1.0)):(rndm (n-1))

-- тренировка нейронной сети на одном примере
train_nn :: Maybe NN -> [Double] -> [Double] -> Maybe NN
train_nn (Nothing) _ _ = Nothing
train_nn (Just(NN il ((OL z s f):t))) x y 
    | (length ((OL z s f):t)) /= (length y) = (Just(NN il ((OL z s f):t)))
    | (f 200) == 1.0 = Just $ NN il $ train_neuron_class ((OL z s f):t) x y
    | otherwise = Just $ NN il $ train_neuron_regr ((OL z s f):t) x y

-- тренировка для классификации
train_neuron_class :: [OutputLauer] -> [Double] -> [Double] -> [OutputLauer]
train_neuron_class [] _ _ = [] 
train_neuron_class ((OL (w:ws) s a):t) x (y:ys)
    | a (s x (w:ws)) == 1.0 = OL (positive_train x (w:ws)) s a : train_neuron_class t x ys
    | otherwise = OL (negative_train x (w:ws)) s a : train_neuron_class t x ys
        where 
            positive_train [] [w1] = [w1 + 0.05]
            positive_train (x1:xs) (w1:ws) = (w1 + abs ((x1*w1)/5) + 0.05) : positive_train xs ws
            negative_train [] [w1] = [w1 - 0.05]
            negative_train (x1:xs) (w1:ws) = (w1 - abs ((x1*w1)/5) - 0.05) : positive_train xs ws

-- тренировка для регрессии
train_neuron_regr :: [OutputLauer] -> [Double] -> [Double] -> [OutputLauer]
train_neuron_regr [] _ _ = [] 
train_neuron_regr ((OL (w:ws) s a):t) x (y:ys) =  OL (train (w:ws)) s a : train_neuron_regr t x ys
    where 
        raz = y - (a (s x (w:ws)))
        k = (a (s x (w:ws)))/y
        train [] = []
        train (u:us)
            | raz > 0 = (u + u*k/5) : train us
            | otherwise = (u - u*k/5) : train us

-- тестирование нейронной сети
test_nn :: Maybe NN -> [Double] -> Maybe [Double]
test_nn (Nothing) _ = Nothing
test_nn (Just(NN il out)) input = Just $ test_neuron out input

-- вспомогательная функция для тестирования
test_neuron :: [OutputLauer] -> [Double] -> [Double]
test_neuron [] _ = []
test_neuron ((OL (w:ws) s a):t) input = (a (s input (w:ws))) : test_neuron t input

-- комплексное обучение нейронной сети на выборке в несколько итераций
complex_train :: Maybe NN -> [[Double]] -> [[Double]] -> Int -> Maybe NN
complex_train (Nothing) _ _ _ = Nothing
complex_train (Just(NN il ol)) _ _ 0 = (Just(NN il ol))
complex_train (Just(NN il ol)) x y n
    | (length x) /= (length y) = (Just(NN il ol))
    | otherwise = complex_train (add_train (Just(NN il ol)) x y) x y (n-1)

-- тренировка для одной итерации
add_train :: Maybe NN -> [[Double]] -> [[Double]] -> Maybe NN
add_train nn [] [] = nn
add_train nn (x:xs) (y:ys) = add_train (train_nn nn x y) xs ys

-- качество классификации нейронной сети 
quality_nn_class :: Maybe NN -> [[Double]] -> [[Double]] -> Maybe (Double, Double, Double, Double)
quality_nn_class (Nothing) _ _ = Nothing
quality_nn_class nn x y 
    | (length x) /= (length y) = Nothing
    | otherwise = Just (acc, prec, recall, f_score)
        where 
            tp_tn_fp_fn = matrix_class nn [0.0,0.0,0.0,0.0] x y 
            tp = tp_tn_fp_fn !! 0
            tn = tp_tn_fp_fn !! 1
            fp = tp_tn_fp_fn !! 2
            fn = tp_tn_fp_fn !! 3
            acc = (tp+tn)/(tp+tn+fp+fn)
            prec = tp/(tp+fp)
            recall = tp/(tp+fn)
            f_score = 2*prec*recall/(prec + recall)

-- подсчет матрицы tp tn fp fn 
matrix_class ::  Maybe NN -> [Double] -> [[Double]] -> [[Double]] -> [Double]
matrix_class nn res [] [] = res 
matrix_class nn [tp,tn,fp,fn] (x:xs) (y:ys) = matrix_class nn (in_mat [tp,tn,fp,fn] (test_nn nn x) y) xs ys

-- вспомогательная функция для matrix_class
in_mat :: [Double] -> Maybe [Double] -> [Double] -> [Double]
in_mat [tp,tn,fp,fn] (Just[]) [] = [tp,tn,fp,fn]
in_mat [tp,tn,fp,fn] (Just (x:xs)) (y:ys)
    | and [x == 1.0, x == y] = in_mat [tp + 1,tn,fp,fn] (Just xs) ys
    | and [x /= 1.0, x == y] = in_mat [tp,tn + 1,fp,fn] (Just xs) ys
    | y == 1.0 = in_mat [tp,tn,fp,fn + 1] (Just xs) ys 
    | otherwise = in_mat [tp,tn,fp + 1,fn] (Just xs) ys 

-- качество регрессионной модели по среднеквадратической ошибке
quality_nn_regr :: Maybe NN -> [[Double]] -> [[Double]] -> Maybe Double
quality_nn_regr (Nothing) _ _ = Nothing
quality_nn_regr nn x y 
    | (length x) /= (length y) = Nothing
    | otherwise = Just sko
        where
            sko = (_sum_/n) ** (0.5)
            sum_n = sum_sqr_error nn [0.0,0.0] x y
            _sum_ = sum_n !! 0
            n = sum_n !! 1

-- подсчет среднеквадратическую ошибку
sum_sqr_error :: Maybe NN -> [Double] -> [[Double]] -> [[Double]] -> [Double]
sum_sqr_error nn [s,n] [] [] = [s,n]
sum_sqr_error nn [s,n] (x:xs) (y:ys) = sum_sqr_error nn (sse [s,n] (test_nn nn x) y) xs ys 

-- вспомогательная функция для sum_sqr_error
sse :: [Double] -> Maybe [Double] -> [Double] -> [Double]
sse [s,n] (Just[]) [] = [s,n]
sse [s,n] (Just (x:xs)) (y:ys) = sse [s + (x-y)**2, n + 1] (Just xs) ys