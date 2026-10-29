// Загрузка идей при старте
document.addEventListener('DOMContentLoaded', loadIdeas);

function addIdea() {
    const ideaInput = document.getElementById('ideaInput');
    const ideaText = ideaInput.value.trim();

    if (ideaText === "") {
        alert('Введите название идеи!');
        return;
    }

    createIdeaElement(ideaText);
    saveIdeas();
    
    ideaInput.value = '';
    ideaInput.focus();
}

function createIdeaElement(text) {
    const ideaList = document.getElementById('ideaList');
    const li = document.createElement('li');
    li.innerHTML = `
        <span>${text}</span>
        <div>
            <button onclick="editIdea(this.previousElementSibling); saveIdeas();">Ред.</button>
            <button onclick="if(confirm('Удалить идею?')) { this.parentElement.parentElement.remove(); saveIdeas(); }">Удалить</button>
        </div>
    `;
    ideaList.appendChild(li);
}

function editIdea(spanElement) {
    const newText = prompt('Редактировать идею:', spanElement.innerText);
    if (newText !== null && newText.trim() !== "") {
        spanElement.innerText = newText.trim();
    }
}

// Сохранение
function saveIdeas() {
    const ideas = [];
    document.querySelectorAll('#ideaList span').forEach(span => {
        ideas.push(span.innerText);
    });
    localStorage.setItem('myIdeas', JSON.stringify(ideas));
}

// Загрузка
function loadIdeas() {
    const saved = localStorage.getItem('myIdeas');
    if (saved) {
        JSON.parse(saved).forEach(text => createIdeaElement(text));
    }
}
