
PRAGMA foreign_keys = ON;

-- 1. Пользователи
CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 2. Категории
CREATE TABLE Categories (
    category_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    color TEXT
);

-- 3. Статусы идей
CREATE TABLE Statuses (
    status_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

-- 4. Приоритеты идей
CREATE TABLE Priorities (
    priority_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

-- 5. Идеи
CREATE TABLE Ideas (
    idea_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    category_id INTEGER,
    status_id INTEGER NOT NULL,
    priority_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    problem TEXT,
    target_audience TEXT,
    features TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
        ON DELETE SET NULL,
    FOREIGN KEY (status_id) REFERENCES Statuses(status_id),
    FOREIGN KEY (priority_id) REFERENCES Priorities(priority_id)
);

-- 6. Планы реализации
CREATE TABLE Plans (
    plan_id INTEGER PRIMARY KEY AUTOINCREMENT,
    idea_id INTEGER NOT NULL,
    plan_name TEXT NOT NULL,
    implementation_plan TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (idea_id) REFERENCES Ideas(idea_id)
        ON DELETE CASCADE
);

-- 7. Цели планов
CREATE TABLE PlanGoals (
    goal_id INTEGER PRIMARY KEY AUTOINCREMENT,
    plan_id INTEGER NOT NULL,
    goal_description TEXT NOT NULL,

    FOREIGN KEY (plan_id) REFERENCES Plans(plan_id)
        ON DELETE CASCADE
);

-- 8. Этапы планов
CREATE TABLE PlanStages (
    stage_id INTEGER PRIMARY KEY AUTOINCREMENT,
    plan_id INTEGER NOT NULL,
    stage_name TEXT NOT NULL,
    stage_description TEXT,
    stage_order INTEGER NOT NULL CHECK (stage_order > 0),

    FOREIGN KEY (plan_id) REFERENCES Plans(plan_id)
        ON DELETE CASCADE,

    UNIQUE (plan_id, stage_order)
);

-- Индексы для ускорения поиска
CREATE INDEX idx_ideas_user ON Ideas(user_id);
CREATE INDEX idx_ideas_category ON Ideas(category_id);
CREATE INDEX idx_ideas_status ON Ideas(status_id);
CREATE INDEX idx_ideas_priority ON Ideas(priority_id);
CREATE INDEX idx_plans_idea ON Plans(idea_id);
