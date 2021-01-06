import Perceptron

show_q :: Maybe (Double,Double,Double,Double) -> String
show_q (Nothing) = ""
show_q (Just(acc, prec, recall, f_score)) = "Accuracy = " ++ (show (acc*100)) ++
    "%\nPrecision = " ++ (show (prec*100)) ++
    "%\nRecall = " ++ (show (recall*100)) ++
    "%\nF1-score = " ++ (show (f_score*100)) ++ "%\n\n"

list_prediction :: Maybe NN -> [[Double]] -> [[Double]]
list_prediction (Nothing) _ = []
list_prediction nn [] = []
list_prediction nn (h:t) = (gett (test_nn nn h))  : (list_prediction nn t)
    where 
        gett (Just a) = a

main :: IO()
main = do
    a <- return $ let nn = createNN_class 2 1 in random_weight nn
    putStr $ "Create NN!\n"
    train_scope <- return $ [[1,1],[0.5,1],[-1,-1],[-1.5,0],[0.2,2],[-0.6,-0.8]]
    train_res <- return $ [[1],[1],[-1],[-1],[1],[-1]]
    putStr $ "Train!\n" ++ (show train_scope) ++ "\n" ++ (show train_res) ++ "\n\n"
    b <- return $ complex_train a train_scope train_res 5
    putStr $ "\nPerceptron: " ++ (show a) ++ "\n\n"
    test_scope <- return $ [[3,3],[-3,-3],[-0.1,0],[0.5,7],[0.3,0.9],[0,-2.0]]
    test_res <- return $ [[1],[-1],[-1],[1],[1],[-1]]
    putStr $ "Test!\n" ++ (show test_scope) ++ "\n" ++ (show test_res)++ "\n" ++ (show (list_prediction b test_scope)) ++ "\n\n"
    res <- return $ quality_nn_class b test_scope test_res
    putStr $ show_q res 