/**
 * 
 */        const slider = document.querySelector('.slider');
        const slides = document.querySelectorAll('.slide');
        const prevBtn = document.querySelector('.prev-btn');
        const nextBtn = document.querySelector('.next-btn');
        let currentIndex = 0;
        const totalSlides = slides.length;

        const updateSliderPosition = () => {
            slider.style.transform = `translateX(-${currentIndex * 100}%)`;
        };

        prevBtn.addEventListener('click', () => {
            currentIndex = currentIndex > 0 ? currentIndex - 1 : totalSlides - 1;
            updateSliderPosition();
        });

        nextBtn.addEventListener('click', () => {
            currentIndex = currentIndex < totalSlides - 1 ? currentIndex + 1 : 0;
            updateSliderPosition();
        });