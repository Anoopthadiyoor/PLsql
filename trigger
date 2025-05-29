q: write a trigger that prevents deleting a epartment from the department table of thereare two employees assigned to it


CREATE OR REPLACE TRIGGER prevent_dept_deletion
BEFORE DELETE ON department
FOR EACH ROW
DECLARE
    emp_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO emp_count
    FROM employee
    WHERE dept_id = :OLD.dept_id;

    IF emp_count >= 2 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Cannot delete department: 2 or more employees are assigned to it.');
    END IF;
END;
/
