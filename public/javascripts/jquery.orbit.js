/*
jQuery Orbit Plugin 1.0
www.ZURB.com/playground
Copyright 2010
*/

/*Coming Features List

1. Bullet Navigation (with this also autoadvance without timer)
2. Theme Classes (white, black, etc.)
3. Caption parameter for not just title, but whatever you want
4. Continuous parameter
5. Allow for image linking

*/

(function($) {

    $.fn.orbit = function(options) {

        //Yo' defaults
        var defaults = {  
            animation: 'fade', //fade, horizontal-slide, vertical-slide
            animationSpeed: 800, //how fast animtions are
            advanceSpeed: 4000, //if auto advance is enabled, time between transitions 
            startClockOnMouseOut: true, //if clock should start on MouseOut
            startClockOnMouseOutAfter: 3000, //how long after mouseout timer should start again
            directionalNav: true, //manual advancing directional navs
            captions: true,
            captionAnimationSpeed: 800,
            timer: false
            };  
        
        //Extend those options
        var options = $.extend(defaults, options); 

        return this.each(function() {
        
            //important global goodies
            var activeImage = 0;
            var numberImages = 0;
            var orbitWidth;
            var orbitHeight;
            var locked;
            
            //Grab each Shifter and add the class
            var orbit = $(this).addClass('orbit')
            
            //Collect all images and set slider size to biggest o' da images
            var images = orbit.find('img');
            images.each(function() {
                var _img = $(this);
                var _imgWidth = _img.width();
                var _imgHeight = _img.height();
                if(_imgWidth > orbit.width()) {
                    orbit.width(_imgWidth);
                    orbitWidth = orbit.width()
                }
                if(_imgHeight > orbit.height()) {
                    orbit.height(_imgHeight)
                    orbitHeight = orbit.height();
                }
                numberImages++;
            });
            
            //set initial front photo z-index
            images.eq(activeImage).css({"z-index" : 3});
            
            //Timer info
            if(options.timer) {
                var timerHTML = '<div class="timer"><span class="mask"><span class="rotator"></span></span><span class="pause"></span></div>'
                orbit.append(timerHTML);
                var timer = $('div.timer')
                var timerRunning;
                if(timer.length != 0) {
                    var speed = (options.advanceSpeed)/180;
                    var rotator = $('div.timer span.rotator')
                    var mask = $('div.timer span.mask')
                    var pause = $('div.timer span.pause')
                    var degrees = 0;
                    var clock;
                    function startClock() {
                        timerRunning = true;
                        pause.removeClass('active')
                        clock = setInterval(function(e){
                            var degreeCSS = "rotate("+degrees+"deg)"
                            degrees += 2
                            rotator.css({ 
                                "-webkit-transform": degreeCSS,
                                "-moz-transform": degreeCSS
                            })
                            if(degrees > 180) {
                                rotator.addClass('move')
                                mask.addClass('move')
                            }
                            if(degrees > 360) {
                                rotator.removeClass('move')
                                mask.removeClass('move')
                                degrees = 0;
                                shift("next")
                            }
                        }, speed);
                    };  
                    function stopClock() {
                        timerRunning = false;
                        clearInterval(clock)
                        pause.addClass('active')
                    }   
                    startClock();
                    timer.click(function() {
                        if(!timerRunning) {
                            startClock();
                        } else { 
                            stopClock();
                        }
                    })
                    if(options.startClockOnMouseOut){
                        var outTimer;
                        orbit.mouseleave(function() {
                            outTimer = setTimeout(function() {
                                if(!timerRunning){
                                    startClock();
                                }
                            }, options.startClockOnMouseOutAfter)
                        })
                        orbit.mouseenter(function() {
                            clearTimeout(outTimer);
                        })
                    }
                }
            }           
            //animation locking functions
            function unlock() {
                locked = false;
            }
            function lock() { 
                locked = true;
            }
            
            //DirectionalNav { rightButton --> shift("next"), leftButton --> shift("prev");
            if(options.directionalNav) {
                var directionalNavHTML = '<div class="slider-nav"><span class="right">Right</span><span class="left">Left</span></div>';
                orbit.append(directionalNavHTML);
                var leftBtn = orbit.children('div.slider-nav').children('span.left');
                var rightBtn = orbit.children('div.slider-nav').children('span.right');
                leftBtn.click(function() { 
                    if(options.timer) { stopClock(); }
                    shift("prev");
                });
                rightBtn.click(function() {
                    if(options.timer) { stopClock(); }
                    shift("next")
                });
            }
            
            //CaptionComputing
            if(options.captions) {
                var captionHTML = '<div class="caption"><p></p></div>';
                orbit.append(captionHTML);
                var caption = orbit.children('div.caption').children('p');
                function setCaption() {
                    //var _caption = images.eq(activeImage).attr('title');
                    var _caption = images.eq(activeImage).attr('caption');
                    var _captionHeight = caption.height() + 20;
                    if(_caption != "") {
                        caption.html(_caption);
                        caption.parent().stop().animate({"bottom" : 0}, options.captionAnimationSpeed);
                    } else { 
                        caption.parent().stop().animate({"bottom" : -_captionHeight}, options.captionAnimationSpeed);
                    }
                }
                if(caption.length != 0){
                    setCaption();
                }
            }
            
            //BulletControls
            
            
            //Animating the shift!
            function shift(direction) {
                //reset Z & Unlock
                function resetAndUnlock() {
                    images.eq(prevActiveImage).css({"z-index" : 1});
                    unlock()
                }
                if(!locked) {
                    lock();
                    //remember previous activeImg
                    var prevActiveImage = activeImage;
                    var slideDirection = direction;
                    //deduce the proper activeImage
                    if(direction == "next") {
                        activeImage++
                        if(activeImage == numberImages) {
                            activeImage = 0;
                        }
                    } else if(direction == "prev") {
                        activeImage--
                        if(activeImage < 0) {
                            activeImage = numberImages-1;
                        }
                    } else {
                        activeImage = direction;
                        if (prevActiveImage < activeImage) { 
                            slideDirection = "prev";
                        } else if (prevActiveImage > activeImage) { 
                            slideDirection = "next"
                        }
                    }
                    //fade
                    if(options.animation == "fade") {
                        images.eq(prevActiveImage).css({"z-index" : 2});
                        images.eq(activeImage).css({"opacity" : 0, "z-index" : 3})
                        .animate({"opacity" : 1}, options.animationSpeed, resetAndUnlock);
                        if(options.captions) { setCaption(); }
                    }
                    //horizontal-slide
                    if(options.animation == "horizontal-slide") {
                        images.eq(prevActiveImage).css({"z-index" : 2});
                        if(slideDirection == "next") {
                            images.eq(activeImage).css({"left": orbitWidth, "z-index" : 3})
                            .animate({"left" : 0}, options.animationSpeed, resetAndUnlock);
                        }
                        if(slideDirection == "prev") {
                            images.eq(activeImage).css({"left": -orbitWidth, "z-index" : 3})
                            .animate({"left" : 0}, options.animationSpeed, resetAndUnlock);
                        }
                        if(options.captions) { setCaption(); }
                    }
                    //vertical-slide
                    if(options.animation == "vertical-slide") { 
                        images.eq(prevActiveImage).css({"z-index" : 2});
                        if(slideDirection == "prev") {
                            images.eq(activeImage).css({"top": orbitHeight, "z-index" : 3})
                            .animate({"top" : 0}, options.animationSpeed, resetAndUnlock);
                        }
                        if(slideDirection == "next") {
                            images.eq(activeImage).css({"top": -orbitHeight, "z-index" : 3})
                            .animate({"top" : 0}, options.animationSpeed, resetAndUnlock);
                        }
                        if(options.captions) { setCaption(); }
                    }
                } //lock
            }//orbit function
        });//each call
    }//orbit plugin call
})(jQuery);
        