module Knn_class (Model_knn(Model_knn),
                z_norm,
                create_knn_model,
                train_knn,
                test_knn) where
import Prelude 

-- модель k близжайших соседей
data Model_knn = Model_knn Int [[Float]] [Int] deriving (Show)

-- математическое ожидание 
math_expect :: [[Float]] -> [Float]
math_expect l = [ x/(fromIntegral(length l)) | x <- (mo l)]
-- вспомогательная функция
mo :: [[Float]] -> [Float] 
mo (h:[]) = h
mo (h:t) = sum_ h (mo t)
-- вспомогательная функция
sum_ :: [Float] -> [Float] -> [Float]
sum_ [] [] = []
sum_ (a1:t1) (a2:t2) = (a1+a2):(sum_ t1 t2)

-- стандартное отклонение
sd_compute :: [[Float]] -> [Float] -> [Float] 
sd_compute dat mO =  [sqrt x | x <- [y/(fromIntegral((length dat)-1)) | y <- (mo (raz dat mO))]]
raz :: [[Float]] -> [Float] -> [[Float]]
raz [] _ = []
raz (h:t) mO = (delt h mO) : (raz t mO)
delt :: [Float] -> [Float] -> [Float]
delt [] [] = []
delt (a:b) (c:d) = ((a-c)*(a-c)):(delt b d)

-- z-преобразование
z_norm :: [[Float]] -> [[Float]]
z_norm [] = []
z_norm dat
    | check_dat dat = z_bend dat (math_expect dat) (sd_compute dat (math_expect dat))
    | otherwise = []
-- вспомогательная функция
z_bend :: [[Float]] -> [Float] -> [Float] -> [[Float]]
z_bend [] _ _ = []
z_bend (h:t) m sd = (zzz h m sd):(z_bend t m sd)
zzz :: [Float] -> [Float] -> [Float] -> [Float]
zzz [] [] [] = []
zzz (a:b) (c:d) (e:f) = ((a - c) / e) :(zzz b d f)
-- вспомогательная функция
check_dat :: [[Float]] -> Bool 
check_dat (h:[]) = True 
check_dat (h1:h2:t)
    | (length h1) == (length h2) = check_dat (h2:t)
    | otherwise = False

-- создать модель
create_knn_model :: Int -> Maybe(Model_knn)
create_knn_model a
    | a > 1 = Just $ Model_knn a [] []
    | otherwise = Nothing 

-- обучить/дообучить модель
train_knn :: Maybe(Model_knn) -> [[Float]] -> [Int] -> Maybe(Model_knn)
train_knn (Nothing) _ _ = Nothing 
train_knn (Just (Model_knn k dat class1)) dat_input class_input 
    | length dat_input == length class_input = Just $ Model_knn k (dat++dat_input) (class1++class_input)
    | otherwise = Just $ Model_knn k dat class1

-- использование модели
test_knn :: Maybe(Model_knn) -> [Float] -> [(Float,Int)] 
test_knn (Nothing) _ = []
test_knn (Just (Model_knn k train clas)) input_data = take k (distance_sort train clas input_data [])
-- сохр.дан., классы, входящее, сохранить, вывести
distance_sort :: [[Float]] -> [Int] -> [Float] -> [(Float,Int)] -> [(Float,Int)]
distance_sort [] [] _ res = res 
distance_sort (h:t) (cl:clas) dat save = distance_sort t clas dat (input_sort (sqrt (vstr h dat)) cl save)
-- вспомогательная функция
vstr :: [Float] -> [Float] -> Float
vstr [] [] = 0
vstr (a:as) (b:bs) = (a-b)*(a-b) + (vstr as bs)
-- вспомогательная функция 
input_sort :: Float -> Int -> [(Float,Int)] -> [(Float,Int)]
input_sort dis clas [] = [(dis,clas)]
input_sort dis clas ((dis_min,cl_min):t) 
    | dis < dis_min = (dis,clas):(dis_min,cl_min):t
    | otherwise = (dis_min,cl_min):(input_sort dis clas t)
