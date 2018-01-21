# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

totalQuestions = 0
jsonObject = '{"answers":[]}'
$(document).ready ->
  $('input:radio[name=answered_question]').click ->
    answer = $('input:radio[name=answered_question]:checked').val()
    question_id = $('input:radio[name=answered_question]:checked').closest('#question').children('h3').html()
    parseObj = JSON.parse(jsonObject)
    parseObj['answers'].push
      'question_id': +question_id
      'answer': answer
    jsonObject = JSON.stringify(parseObj)
    totalQuestions = totalQuestions + 1
    if totalQuestions == 10
      $('input#quiz_answered_question').val jsonObject
      console.log jsonObject
    $('input:radio[name=answered_question]:checked').closest('#question').hide()
    return
  return