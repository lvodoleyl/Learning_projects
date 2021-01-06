import Perceptron

show_sco :: Maybe Double -> String
show_sco (Nothing) = "Nothing"
show_sco (Just a) = "\nMSE = " ++ (show a) ++ "\n"

list_prediction :: Maybe NN -> [[Double]] -> [[Double]]
list_prediction (Nothing) _ = []
list_prediction nn [] = []
list_prediction nn (h:t) = (gett (test_nn nn h))  : (list_prediction nn t)
    where 
        gett (Just a) = a

main :: IO()
main = do
    a <- return $ let nn = createNN_regr 1 1 in random_weight nn
    putStr $ "Create NN!\n"
    train_scope <- return $ [[1], [2], [3], [4], [5], [5.5]]
    train_res <- return $ [[1], [2], [3], [4], [5], [5.5]]
    putStr $ "Train!\n" ++ (show train_scope) ++ "\n" ++ (show train_res) ++ "\n\n"
    b <- return $ complex_train a train_scope train_res 3
    putStr $ "\nPerceptron: " ++ (show a) ++ "\n\n"
    test_scope <- return $ [[1.5], [7], [12], [0.2], [0.0]]
    test_res <- return $ [[1.5], [7], [12], [0.2], [0.0]]
    putStr $ "Test!\n" ++ (show test_scope) ++ "\n" ++ (show test_res) ++ "\n" ++ (show (list_prediction b test_scope)) ++ "\n\n"
    res <- return $ quality_nn_regr b test_scope test_res
    putStr $ show_sco res 