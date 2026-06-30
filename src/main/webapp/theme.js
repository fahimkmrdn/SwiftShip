const storedTheme = localStorage.getItem('swiftship-theme');
const preferredTheme = storedTheme ? storedTheme : 'light';

document.documentElement.setAttribute('data-bs-theme', preferredTheme);

function toggleTheme() {
    const currentTheme = document.documentElement.getAttribute('data-bs-theme');
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    
    document.documentElement.setAttribute('data-bs-theme', newTheme);
    localStorage.setItem('swiftship-theme', newTheme);
    
    updateThemeIcon(newTheme);
}

function updateThemeIcon(theme) {
    const icons = document.querySelectorAll('.theme-icon-toggle');
    icons.forEach(icon => {
        if (theme === 'dark') {
            icon.classList.remove('bi-moon-fill');
            icon.classList.add('bi-sun-fill');
            icon.classList.add('text-warning');
        } else {
            icon.classList.remove('bi-sun-fill', 'text-warning');
            icon.classList.add('bi-moon-fill');
        }
    });
}

document.addEventListener('DOMContentLoaded', () => {
    updateThemeIcon(document.documentElement.getAttribute('data-bs-theme'));
});