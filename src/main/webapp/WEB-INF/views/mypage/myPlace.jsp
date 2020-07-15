<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<!doctype html>
	<html lang="zxx">
	
	<!-- head.jsp -->
	<jsp:include page="../include/head.jsp"/>
	
	<body>
		<!--::header part start::-->
		<!-- header.jsp --> 
	    <jsp:include page="../include/hearder.jsp"/>
		<!-- Header part end-->
	
		<jsp:include page="../include/mypageLeft.jsp"/>
							<section class="left_main" style="padding-top: 100px;padding-left: 70px;">
							<div class="container1">
							      <div class="row"style="padding-bottom: 50px;">
							        <div class="col-12" style="text-align: center;">
							          <img src="../resources/img/myPage/동네인증1.png" alt="" width="280px;"/>
							        </div>
							        </div>
							        <div id="map" style="height: 480px;"></div>
							        <script>
							          function initMap() {
							            var uluru = {
							              lat: -25.363,
							              lng: 131.044
							            };
							            var grayStyles = [{
							                featureType: "all",
							                stylers: [{
							                    saturation: -90
							                  },
							                  {
							                    lightness: 50
							                  }
							                ]
							              },
							              {
							                elementType: 'labels.text.fill',
							                stylers: [{
							                  color: '#ccdee9'
							                }]
							              }
							            ];
							            var map = new google.maps.Map(document.getElementById('map'), {
							              center: {
							                lat: -31.197,
							                lng: 150.744
							              },
							              zoom: 9,
							              styles: grayStyles,
							              scrollwheel: false
							            });
							          }
							        </script>
							        <script
							          src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDpfS1oRGreGSBU5HHjMmQ3o5NLw7VdJ6I&callback=initMap">
							        </script>
							     
							      <div class="row">
							        <div class=""style="padding-left: 30px; padding-top: 50px;">
							          <form class="form-contact contact_form" action="contact_process.php" method="post" id="contactForm"
							            novalidate="novalidate">
							            <div class="row">
							              <div class="col-12">
							                <div class="form-group">
							                  <input class="form-control" name="" id="" type="text" onfocus="this.placeholder = ''"
							                    onblur="this.placeholder = '현재 동네'" placeholder='현재 동네'>
							                </div>
							              </div>
							              <div class="col-6">
							                <div class="form-group">
							                  <input class="form-control" name="" id="" type="text" onfocus="this.placeholder = ''"
							                    onblur="this.placeholder = '서울시 금천구'" placeholder='서울시 금천구'>
							                </div>
							              </div>
							              <div class="col-6">
							                <div class="form-group">
							                  <input class="form-control" name="" id="" type="text" onfocus="this.placeholder = ''"
							                    onblur="this.placeholder = '가산동'" placeholder='가산동'>
							                </div>
							              </div>
							            </div>
							            <div class="form-group mt-3" style="text-align: right;">
							              <button href="#" class="btn_3 button-contactForm" >인증하기</button>
							            </div>
							          </form>
							        </div>
							        
							      </div>
							    </div>
							</section>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		<!--================Blog Area =================-->
	<!-- bottom.jsp -->
	    <jsp:include page="../include/bottom.jsp"/>
	    <jsp:include page="../include/sidebar.jsp"/>
	</body>
	
	</html>