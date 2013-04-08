questions = [{
  question: "Who is Prime Minister of the United Kingdom?",
  choices: ["David Cameron", "Gordon Brown", "Winston Churchill", "Tony Blair"],
  correctAnswer: 0
},
{
  question: "Which country has the most desert landmass?",
  choices: ["Sahara", "Chile", "Russia"],
  correctAnswer: 2
},
{
  question: "What year did the USA land a person on the moon?",
  choices: ["IT WAS A HOAX", "1967", "1969"],
  correctAnswer: 2
},
{
  question: "How many drugs did the Beatles consume?",
  choices: ["The Beatles were drug-free", "All the drugs", "Soft drugs like marijuana"],
  correctAnswer: 1 
},
{
  question: "What is the average velocity of an African swallow?",
  choices: ["Your father smells of elderberries", "32mph", "I will destroy you"],
  correctAnswer: 0  
},
{
  question: "Do you like bicycles?",
  choices: ["No", "They're okay", "Are there things besides bicycles?"],
  correctAnswer: 2
}]

iteration = 0
sumCorrect = 0

addQuestion = (question) ->
  question_el = document.getElementById "question"
  question_el.innerHTML = '<h2>Question #' + (iteration + 1) +
    '</h2><p class="question">' + question + '</p>'

addAnswer = (choice, answer) ->
  input = document.getElementById choice
  label = document.getElementById "label_" + choice
  label.innerHTML = answer
  input.value = answer
    
insertStuff = ->
  if questions[iteration] == undefined
    ender()
  else
    addQuestion questions[iteration].question
    addAnswer "a", questions[iteration].choices[0]
    addAnswer "b", questions[iteration].choices[1]
    addAnswer "c", questions[iteration].choices[2]

validator = ->
  chosen_answer = null
  correct_answer = questions[iteration].correctAnswer
  form = document.getElementById "fieldset"
  radios = form.getElementsByTagName "input"
  for i in [0..(radios.length - 1)] by 1
    if radios[i].checked
      chosen_answer = i
      radios[i].checked = false
      break
    else
      i++
  return chosen_answer
    
controller = ->
  correct_answer = questions[iteration].correctAnswer
  result_el = document.getElementById 'result'
  answer = validator()
  if answer == null # no answer given
    result_el.innerHTML = '<p style="color:red">GIVE AN ANSWER YOU DUMMY</p>'
    callback = ->
      result_el.innerHTML = ''
    setTimeout callback, 2500
    
  else # some answer given
    if answer == correct_answer
      result_el.innerHTML = '<p style="color:green">Correct!</p>'
      callback = ->
        result_el.innerHTML = ''
        sumCorrect += 1
        iteration += 1
        insertStuff()
      setTimeout callback, 1500
    else # WRONG
      result_el.innerHTML = '<p style="color:red">Sorry, incorrect!</p>'
      callback = ->
        result_el.innerHTML = ''
        iteration += 1
        insertStuff()
      setTimeout callback, 1500

ender = ->
  content = document.getElementById 'content'
  playerStatus = 'horrible' # want to make this dynamic at some point
  content.innerHTML = '<h2>You got ' + sumCorrect + '/' + iteration + ' correct.</h2>' +
    '<h4>You are a ' + playerStatus + ' person.</h4>' +
    '<p><a href="mailto:polyrhythm@gmail.com">Fuck you</a></p>'
      
insertStuff() # initial population of stuff
submit = document.getElementById 'submit'
submit.onclick = ->
  controller()