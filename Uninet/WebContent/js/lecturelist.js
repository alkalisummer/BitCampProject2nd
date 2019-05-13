function makePageBtns() {
  const option = $("#option").text();
  const word = $("#word").text();
  const currentPage = Number($("#currentPage").text());
  const totalPages = Number($("#totalPages").text());
  const startPage = Number($("#startPage").text());
  const endPage = Number($("#endPage").text());
  console.log(currentPage);
  const boardBottom = $(".board-bottom");
  const pageBtns = $(".page-btns");
  
  if (currentPage !== 1) {
    boardBottom.prepend("<div class='btn prev-page'>&lt;&nbsp;이전</div>");
  } else {
    boardBottom.prepend("<div class='btn prev-page hidden'>&lt;&nbsp;이전</div>");
  }
  if (currentPage > 3) {
    pageBtns.append("<div class='btn prv-btn'>&lt;</div>");
  }
  
  for (let i = startPage; i <= endPage; i++) {
    if (i === currentPage) {
      pageBtns.append("<div class='btn page-btn current-btn'>" + i + "</div>");
    } else {
      pageBtns.append("<div class='btn page-btn'>" + i + "</div>");
    }
  }
  
  if (totalPages > endPage) {
    pageBtns.append("<div class='btn next-btn'>&gt;</div>");
  }
  
  if (currentPage < totalPages) {
    boardBottom.append("<div class='btn next-page'>다음&nbsp;&gt;</div>");
  } else {
    boardBottom.append("<div class='btn next-page hidden'>다음&nbsp;&gt;</div>");
  }
}

function checkPrevBtnAndNextBtn() {
  const currentPage = Number($("#currentPage").text());
  const method = $("#method").text();
  const option = $("#option").text();
  const word = $("#word").text();
  const totalPages = Number($("#totalPages").text());
  $(".next-page").click(function () {
    if (currentPage !== 1 && !$(this).hasClass("hidden")) {
      callResult(currentPage + 1, method, option, word);
    }
  });

  $(".prev-page").click(function () {
    if (currentPage !== totalPages && !$(this).hasClass("hidden")) {
      callResult(currentPage - 1, method, option, word);
    }
  });
}

function callResult(page, method, option, word) {
  const ajax = {
      url: "search",
      method: "post",
      data:{
        page: page,
        method: method,
        option: option,
        word: word
      },
      dataType: "html",
      success: function(data) {
        console.log(data);
        $("#searchResult").html(data);
      }  
  };
  
  $.ajax(ajax).done(function() {
    $(".page-btn").off("click");
    $(".board-bottom").empty();
    $(".board-bottom").append("<div class='page-btns'></div>");
    makePageBtns();
    checkPrevBtnAndNextBtn();
    $(".page-btn").click(function() {
      const pageNo = $(this).text();

      $(".page-btns").children(".current-btn").removeClass("current-btn");
      $(this).addClass("current-btn");
      $.ajax({
        url: "search",
        method: "post",
        dataType: "html",
        data: {
          page: pageNo,
          method: method,
          option: option,
          word: word
        },
        success: function(data) {
          console.log(data);
          $("#searchResult").html(data);
        }
      });
    })
  });

}

$(function() {
  callResult(1, "default");
  
  $("#closeBtn").click(function() {
    const textInput = $("#searchInput").val();
    const option = $("input[name='searchradio']:checked").val();
    callResult(1, "search", option, textInput);
  });
  
  $("#closeBtn2").click(function() {
    const optionValue = $("input[name='sort']:checked").val();
    callResult(1, "sort", optionValue);
  }) 
});

const modalBtns = [...document.querySelectorAll(".button")];
modalBtns.forEach(function(btn) {
  btn.onclick = function() {
    const modal = btn.getAttribute("data-modal");
    document.getElementById(modal).style.display = "block";
  };
});

const closeBtns = [...document.querySelectorAll(".close")];
const closeBtns2 = [...document.querySelectorAll("#closeBtn")];
const closeBtns3 = [...document.querySelectorAll("#closeBtn2")];
closeBtns.forEach(function(btn) {
  btn.onclick = function() {
    const modal = btn.closest(".modal");
    modal.style.display = "none";
  };
});

closeBtns2.forEach(function(btn) {
  btn.onclick = function() {
    const modal = btn.closest(".modal");
    modal.style.display = "none";
  };
});

closeBtns3.forEach(function(btn) {
  btn.onclick = function() {
    const modal = btn.closest(".modal");
    modal.style.display = "none";
  };
});

window.onclick = function(event) {
  if (event.target.className === "modal") {
    event.target.style.display = "none";
  }
};