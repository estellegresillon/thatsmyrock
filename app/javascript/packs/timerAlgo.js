const algo = document.querySelector('.algo-div')
const recommandation = document.querySelector('.recommandation-modal')
const button = document.querySelector('.btn-modal')



function changeDiv() {
  algo.style.display = "none"
  recommandation.style.display = "block"
}

button.addEventListener('click', function(e) {
  // clearInterval(timer)
  // algo.style.display = "flex"
  // recommandation.style.display = "none"
  let timer = window.setInterval(changeDiv, 5500)
})



