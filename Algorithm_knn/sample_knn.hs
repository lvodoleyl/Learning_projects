import Knn_class
import Prelude  


main :: IO() 
main = do
    dat <- return $ [[300,0,0], [0,3,0], [0,0,3],
                    [600,2,1], [-300,5,1], [-100,1,9],
                    [500,0,-1], [-100,7,-2],[-100,0,4]]
    cl <- return $ [1,2,3,1,2,3,1,2,3]
    putStr $ "Data:\n" ++ show(dat) ++ "\nClass:\n" ++ show(cl) ++ "\n"
    z_dat <- return $ z_norm dat
    putStr $ "Z-преобразование:\n" ++ show(z_dat) ++ "\n"
    a <- return $ create_knn_model 3
    putStr $ "Create knn model!\n"
    b <- return $ train_knn a z_dat cl 
    putStr $ "Train knn model!\n"
    
    z_test <- return $ (z_norm ([[236,-2,2]]++ dat)) !! 1
    res <- return $ test_knn b z_test 
    putStr $ "Test knn model!\n"
    putStr $ show(res) ++ "\n"

    z_test1 <- return $ (z_norm ([[0,0,3]]++ dat)) !! 1
    res1 <- return $ test_knn b z_test1 
    putStr $ "Test knn model!\n"
    putStr $ show(res1) ++ "\n"
