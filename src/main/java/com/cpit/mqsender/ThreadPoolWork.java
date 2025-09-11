package com.cpit.mqsender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;

@Service
public class ThreadPoolWork {
	@Qualifier("threadPoolA")
	@Autowired
	private ThreadPoolTaskExecutor threadPoolTaskExecutor;

	public void doWork(Runnable task) {
			threadPoolTaskExecutor.execute(task);
	}
}

