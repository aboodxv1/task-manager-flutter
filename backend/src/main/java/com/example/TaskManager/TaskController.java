package com.example.TaskManager;

import java.util.List;

import org.aspectj.lang.annotation.RequiredTypes;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;



@RestController
@RequestMapping("/api/tasks")
@CrossOrigin
@RequiredArgsConstructor // lombok todo * 
public class TaskController {
    
    private final TaskRepository repo;

    

    @GetMapping
     public List<Task> all() {
        return repo.findAll();
    }

    @PostMapping
    public Task add(@RequestBody Task task) {
        return repo.save(task);
    }

    @PutMapping("/{id}")
    public Task Update(@PathVariable Long id, @RequestBody Task task){

        task.setId(id);
        return repo.save(task);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {

        repo.deleteById(id);
    }

}
