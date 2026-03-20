package com.wishlist.model.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

@Configuration
public class MybatisConfig {
	
	private final ApplicationContext applicationContext;
	
	public MybatisConfig(ApplicationContext applicationContext) {
		this.applicationContext = applicationContext;
	}
	
	@Bean
	SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
	  SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
	  sqlSessionFactoryBean.setDataSource(dataSource); // 데이터 소스 설정
	 // sqlSessionFactoryBean.setConfigLocation(new ClassPathResource("mybatis-config.xml"));
	  sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:mapper/**/*.xml"));
	  return sqlSessionFactoryBean.getObject(); // SqlSessionFactory 반환
	}

	@Bean
	SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
	   return new SqlSessionTemplate(sqlSessionFactory); // SqlSessionTemplate 반환
	 }
}
