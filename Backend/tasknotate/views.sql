CREATE OR REPLACE VIEW EmployeeTaskView AS
SELECT 
    ec.user_id,
    c.company_ID,
    c.company_name,
    c.company_image,
    c.company_description,
    c.company_job,
    t.id AS task_id,
    t.title AS task_title,
    t.description AS task_description,
    t.created_on,
    t.due_date,
    t.priority,
    t.status,
    f.id AS file_id,
    f.filename AS file_name,
    f.file_url,
    f.uploaded_at,
    s.id AS subtask_id,
    s.title AS subtask_title,
    s.description AS subtask_description
FROM employee_company ec
INNER JOIN company c ON ec.company_id = c.company_ID
LEFT JOIN tasks t ON t.company_id = c.company_ID
LEFT JOIN attachments f ON f.task_id = t.id
LEFT JOIN subtasks s ON s.task_id = t.id;


