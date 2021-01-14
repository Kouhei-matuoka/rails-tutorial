class Question < ApplicationRecord
  
  SCORE_TABLE = {'a' => 1, 'b' => 2, 'c' => 3}

  def calc_score
    puts first_answer
    puts second_answer
    puts third_answer
    puts fourth_answer
    SCORE_TABLE[first_answer] + SCORE_TABLE[second_answer] + SCORE_TABLE[third_answer] + SCORE_TABLE[fourth_answer]
  end
end
