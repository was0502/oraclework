031/*
(') 홀따옴표: 문자열
(") 쌍따옴표: 컬럼명
*/

/*
<SELECT>
데이터 조회할 때 사용하는 구문

>> RESULT SET : SELECT구문을 통해서 조회된 결과물(즉, 조회된 행들의 집합)

[표현법]
SELECT 조회하고자하는 컬럼명, 컬럼명, ...
FROM 테이블명;
*/
-- EMPLOYER테이블의 모든 컬럼(*) 조회
SELECT *
FROM employee;

SELECT *
FROM DEPARTMENT;

SELECT * FROM JOB;

-- EMPLOYER테이블에서 사번, 이름, 급여만 조회
SELECT EMP_ID, EMP_NAME, SALARY 
 FROM employee;

------------실선
-- DEPARTMENT테이블에서 부서코드, 부서명만 조회
----------실습문제---------
--1. job테이블에 직급명만 조회
--2. DEPARTMENT 테이블의 모든 컬럼 조회
--3. DEPARTMENT 테이블의 부서코드, 부서명만 조회
--4. DEPARTMENT 테이블의 사원명, 이메일, 전화번호, 입사일, 급여 조회

/*
    <컬럼값을 통한 산술연산>
    SELECT절의 컬럼명 작성부분에 산술연산 기술 가능(이때 산술연산된 결과 조회)
*/
-- EMPLOYER테이블에서 사원명, 사원의 연봉(급여*12) 조회
SELECT EMP_NAME, SALARY*12
 FROM EMPLOYEE;
 
 -- EMPLOYEE테이블 사원명, 급여, 보너스
 SELECT EMP_NAME, SALARY, BONUS
  FROM EMPLOYEE;
  
  -- EMPLOYEE 사원명, 급여, 보너스, 연봉, 보너스를 포함한 연봉 ( (급여+보너스+급여)*12) )
  SELECT EMP_NAME, ALARY, BONUS, SALARY*12, (SALARY+BONUS*SALARY)*12
  FROM EMPLYEE;
  --> 산술연산 중 NULL과 같이 존재할 경우 산술연상한 결과값도 무조건 NULL이 됨
  
  --EMPLYEE테이블 사원명, 입사일, 근무일수(오늘날짜-입사일)
  --DATE형태끼리도 연산 가능 : 결과값은 일 단위
  -- *오늘날짜 : SYSDATE
  SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE
   FROM EMPLOYEE;
   -- 소수점까지 나오는 이유는 초단위까지 관리하기 때문
   
   --------------------------------------------------
   /*
    <컬럼명에 별칭 지정하기>
    산술연산시 컬럼명이 산술에 들어간 수식 그대로 됨. 이때 별칭을 부여하면 별칭이 컬럼명이 됨
    
    [표현법]
    컬럼명 별칭
    컬럼명 AS 별칭
    컬럼명 "별칭"
    컬럼면 AS "별칭"
    */
    
SELECT EMP_NAME, SALARY, BONUS, SALARY*12 연봉, {SALARY+BONUS*SALARY)*12 AS 총 연봉
 FROM EMPLOYEE;
 
 --별칭에 특수기호나 띄어쓰기가 들어가면 반드시 쌍따옴표(")로 묶어줘야함
 SELECT EMP_NAME, SALARY, BONUS, SALARY*12 "연봉(원)", {SALARY+BONUS*SALARY)*12 AS "총 연봉"
 FROM EMPLOYEE;
 
 -- 위의 예제에서 사원명, 급여, 보너스, 연봉(원), 총 연봉 별칭부여하기
  SELECT EMP_NAME 사원명, SALARY AS 급여, BONUS "보너스", SALARY*12 "연봉(원)", {SALARY+BONUS*SALARY)*12 AS "총 연봉"
 FROM EMPLOYEE;
 ------------------------------------------------------------------
 /*
    <리터럴>
    임의로 지정한 문자열(')
    
    SELECT절에 리터럴을 넣으면 마치 테이블상에 존재하는 데이터 처럼 조회 가능
    조회된 RESULT SET의 모든 행에 반복적으로 같이 출력
    */
    -- EMPLYEE 사번, 사원명, 급여 조회 - 급여옆에 원을 넣어주도록함
SELECT EMP_IC, EMP_NAME, SALARY, '원' AS 단위
 FROM EMPLYEE;
 
 --------------------------------------------------------------------
 /*
 <연결 연산자 : ||>
 여러 컬럼값을 마치 하나의 컬럼값인것처럼 연결하거나, 컬럼값과 리터럴을 연결할 수 있음
 */
 -- EMPLOYEE 사번, 사원명, 급여를 하나의 커럼으로 조회
 SELECT EMP_ID || EMP_NAME || SALARY AS "사원의 급여"
  FROM EMPLOYEE;
  
-- 컬럼값과 리터럴과 연결
SELECT EMP_NAME || '의 월급은 ' || SALARY || '원 입니다'
 FROM EMPLOYEE;
 
 SELECT EMP_ID, EMP_NAME, SALARY || '원'
  FROM EMPLOYEE;
  -------------------------------------------------------------------
  
  /*
    <DISTINCT>
    컬럼에 중복된 값들은 한번씩만 표시하고자 할 때
 */

-- EMPLOYEE에 부서코드 중복제거 조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

-- EMPIOYEE에 직급코드 중복제거 조회
SELECT DISTINCT JOB_CODE
 FROM EMPLOYEE;
 -- 주의사항 : DISTINCT는 SELECT절에 딱 한번만 기술 가능
 -- SELECT DISTINCT DEFT_CODE DISTINCT JOB_CODE
 SELECT DISTINCT DEFT_CODE, JOB_CODE -- 2개의 조합으로 1번
  FROM EMPLOYEE;
  
  ------------------------------------------------------------------
  /*
    <WHERE 절>
    조회하고자 하는 테이블로부터 특정조건에 만족하는 데이터만 조회할 때
    이때 WHERE절에 조건식을 쓰면 됨
    조건식에서는 다양한 연산자 사용가능
    
    [표현법]
    SELECT 컬럼명, ...
    FROM 테이블명
    WHERE 조건식;
    
    - 비교연산자
    >, <, >=, <= --> 대소비교
    =            --> 같은지 비교
    !=, ^=, <>   --> 같지않은지 비교
 */
 
 -- EMPLOYEE에서 부서코드가 'D9'인 사람들의 모든 컬럼 조회
 SELECT*
  FROM EMPLYEE
 WHERE DEFT_CODE = 'D9';
 
 -- EMPLOYEE에서 부서코드가 'D1'인 사원들의 사원명, 급여, 부서코드 조회
 SELECT EMP_NAME, SALECT, DEFT_CODE
 FROM EMPLOYEE
 WHERE DEPT_CODE = 'D1';
 
 -- EMPLOYEE에서 부서코드가 'D1'이 아닌 사원들의 사원명, 이메일, 부서코드 조회
 SELECT EMP_NAME, EMAIL, DEPT_CODE
  FROM EMPLOYEE
 -- WHERE DEPT_CODE != 'D1';
 -- WHERE DEPT_CODE ^= 'D1';
 WHERE DEPT_CODE<> 'D1';
 
 -- EMPLOYEE에서 급여가 4백만원 이상인 사원들의 사원명, 부서코드, 급여조회
  SELECT EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
  WHERE SALARY >= 4,000,000;
  
  -- EMPLOYEE에서 재직중인 사원의 사원명, 전화번호 조회
 SELECT EMP_NAME, PHONE
   FROM EMPLOYEE
 WHERE ENT_YN = 'N';
 ------실습 문제------
 -- 1. 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, (연봉) 조회
  SELECT EMP_NAME, SALARY, HIRE_DATE, SALARY, SALARY*12
    FROM EMPLOYEE
  WHERE SALARY >= 3000000;
-- 2. 연봉이 5000만원 이상인 사원들의 사원명, 급여, (연봉), 부서코드 조회
   SELECT EMP_NAME, SALARY, SALARY*12, DEPT_CODE
    FROM EMPLOYEE
  WHERE SALARY*12 >= 50000000;
 3. 직급코드가 'J3'이 아닌 사원들의 사번, 사원명, 직급코드, (퇴사여부) 조회
  SELECT EMP_ID, EMP_NAME, JOB_CODE, ENT_YN
  FROM EMPLOYEE
 WHERE DEPT_CODE<> 'D3';
  ------------------------------------
  /*
   <논리 연산자>
   AND (그리고, -이연선)
   OR (또는, -이거나)
   */
   
   --EMPLOYEE부서코드가 'D9'이면서 급여가 500만원 이상인 사원들의 사원명, 부서코드, 급여 조회
 SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D9' AND SALARY >=5000000;
   
   --EMLPOYEE에서 부서코드가 'D9'이거나 급여가 300만원 이상인 사원들의 사원명, 부서코드, 급여 조회
 SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D9' OR SALARY >=3000000;
   -- EMPLOYEE에서 급여가 350만원 이상 600만원 이하인 사원들의 사원명, 사번, 급여 조회
 SELECT EMP_NAME, EMP_ID, SALARY
  FROM EMPLOYEE
  -- WHERE 3500000 <= SALARY <= 6000000 --오류 
 WHERE 3500000 <= SALARY AND SALARY <=6000000;
        
---------------------------------------------------------------
/* 
<BETWEEN AND>
조건식에서 사용되는 구문
-이상 -이하인 범위에 대한 조건을 제시할 사용하는 연산자

[표현법]
비교대상컬럼 BETWEEN 하한값 AND 상한값
-> 해당 컬럼값이 하한값이고 상한값 이하인 경우
*/
 SELECT EMP_NAME, EMP_ID, SALARY
  FROM EMPLOYEE
 WHERE SALARY BETWEEN 3500000 AND 6000000;
 
 -- 입사일이 2000년 이전에 들어온 사원의 모든 컬럼 조회
 SELECT EMP_NAME, HIRE_DATE
  FROM EMPLOYEE
-- WHERE HIRE_DATE BETWEEN '90/01/01' AND '99/01/01';
 WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '99/12/31';
     
----------------------------------------------------
/*
    <LIKE>
    비교하고자하는 컬럼값이 내가 제시한 특정 패턴에 만족하는 경우 조회
    
    [표현법]
    비교대상컬럼 LIKE '특정패턴'
    : 특정패턴 제시사 '%',' '를 와일드카드로 쓸 수 있음
    
    >> '%' : 0글자 이상
    EX) 비교대상컬럼 LIKE '문자%' => 비교대상의 컬럼값이 '문자'로 시작되는 데이터 조화
        비교대상컬럼 LIKE '%문자' => 비교대상의 컬럼값이 '문자'로 시작되는 데이터 조화
        비교대상컬럼 LIKE '%문자%' => 비교대상의 컬럼값이 '문자'가 포함되어 있는 데이터 조화
        
    >> '_' : 1글자
    EX) 비교대상컬럼 LIKE '_문자' => 비교대상의 컬럼값이 '문자'앞에 무조건 한글자가 들어있는 데이터 조회
        비교대상컬럼 LIKE '_ _문자' => 비교대상의 컬럼값이 '문자'앞에 무조건 두글자가 들어있는 데이터 조화
        비교대상컬럼 LIKE '_문자_' => 비교대상의 컬럼값이 '문자'앞에 무조건 한글자, 뒤에도 무조건 한글자가 들어있는 데이터 조화
*/

-- EMPLOYEE에서 사원 성이 전씨인 사원들의 사원명, 급여, 인사일 조회
 SELECT EMP_NAME, SALARY, HIRE_DATE
  FROM EMPLOYEE
 WHERE EMP_NAME LIKE '전%';
 -- EMPLOYEE에서 사원의 이름에 '하'자가 들어있는 사원의 사원명, 이메일, 전화번호 조회
 SELECT EMP_NAME, EMAIL, PHONE
  FROM EMPLOYEE
 WHERE EMP_NAME LIKE '%하%';
 
 -- EMPLOYEE에서 사원의 이름에 중간에 '하'자가 중간에 들어있는 사원의 사원명, 이메일, 전화번호 조회
 SELECT EMP_NAME, EMAIL, PHONE
  FROM EMPLOYEE
 WHERE EMP_NAME LIKE '_ _하';
 
 --EMPLYEE에서 전화번호의 3번째 자리가 '1'인 사원의 사원명, 전화번호 조회
  SELECT EMP_NAME, PHONE
  FROM EMPLOYEE
 WHERE PHONE LIKE '__1%';
 
 -- 이메일중 _(언더바) 앞에 글자가 3글자인 사원들의 사원명, 이메일 조회
 SELECT EMP_NAME, EMAIL
  FROM
 WHERE EMWAIL LIKE '___%';
 -- 와일드카드로 사용하는 문자와 컬럼값에 들어있는 문자가 동일하기 때문에 조회 안됨
 -- 모두다 와일드카드로 인식
 /*
    > 와일드카드와 문자를 구분해줘야 함
    > 나만의 와일드카드를 ESCAPE로 등록
     - 데이터값으로 취급하고자하는 값 앞에 나만의 와일드카드(문자, 숫자, 특수문자)를 넣어줌
     - 특수기호 '&'는 안ㅆ느느것이 좋다. 사용자로부터 입력받을 때 &를 사용함
 */
 
 SELECT EMP_NAME, EMAIL
  FROM EMPLOYEE
 WHERE EMWAIL LIKE '__d_%'ESCAPE 'd';
 ------실습문제-----
 --1. EMPLOYEE에서 이름이 '연'으로 끝나는 사원들의 사원명, 입사일 조회
 SELECT EMP_NAME, HIRE_DATE
  FROM EMPLOYEE
 WHERE EMP_NAME LIKE '__연%';
 
 --2. EMPLOYEE에서 전화번호 처음 3자리가 010이 아닌 사원들의 사원명, 전화번호 조회
 SELECT EMP_NAME, PHONE
  FROM EMPLOYEE
 WHERE PHONE NOT LIKE '010%';
 
 3. EMPLOYEE에서 이름에 '하'가 포함되어 있고 급여가 240만원이상인 사원들의 사원명, 급여 조회
  SELECT EMP_NAME, SALARY
  FROM EMPLOYEE
 WHERE EMP_NAME LIKE '%하%' AND SALARY >=2400000;
 
 4. DEPARTMENT에서 해외영업부인 부서들의 부서코드, 부서명 조회
 SELECT DEPT_ID, DEPT_TITLE
  FROM DEPARTMENT;
 WHERE DEPT_TITLE LIKE '해외영업%';
 ---------------------------------------------------------
 /*
    <IS NULL / IS NOT NULL>
    컬렁값에 NULL이 있을 경우 NULL값 비교에 사용하는 연산자
 */
 -- EMPLOYEE에서 보너스를 받지 않는 사원의 사원명, 급여, 보너스 조회
 SELECT EMP_NAME, SALARY, BONUS
  FROM EMPLOYEE
 -- WHERE BONUS = NULL;-- 조회안됨
 WHERE BONUS IS NOT NULL; 
 
 -- EMPLOYEE에서 사수가 없는(MANEGER_ID값이 NULL인)사원의 사원명, 부서코드 조회
EMP_NAME, DEPT_CODE, MANAGER_ID
  FROM EMPLOYEE
 WHERE MENEGER_ID IS NULL; 
 
 -- EMPLOYEE 부서배치를 받지 않았지만 보너스는 받는 사원의 사원명, 보너스, 부서코드 조회
 SELECT EMP_NAME, BONUS, DEPT_CODE
  FROM EMPLOYEE
 WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL; 
 
 ----------------------------------------------------------------------
 /*
    <IN / NOT IN>
    IN : 컬럼값이 내가 제시한 목록중에 일치하는 것만 조회
    NOT IN : 컬럼값이 내가 제시한 목록중에 일치하는 값을 제외하고 조회
    
    [표현법]
    비교대상컬럼 IN('값1', '값2', '값3',...))
*/
--EMPLOYEE에서 부서코드가 D6이거나 D8이거나 D5인 사원들의 사원명, 부서코드, 급여조회
 SELECT EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
 -- WHERE DEPT_CODE 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5'; 
 WHERE DEPT_CODE IN ('D6', 'DB', 'D5');
 -------------------------------------------------------------
 /*
    <연산자 우선순위>
    1. ()
    2. 산술연산자
    3. 연결연산자
    4. 비교연산자
    5. IS NULL / LIKE '특정패턴' / IN
    6. BETWEEN AND
    7. NOT(논리연산자)
    8. AND(논리연산자)
    9. OR(논리연산자)
 */
 -- ** AND가 OR보다 순위 더 높다
 -- 직급코드가 J7이거나 J2인 사원들 중 급여가 200만원 이상인 사원들의 사원명, 급여, 직급코드 조회
 SELECT EMP_NAME, SALARY, JOB_CODE
  FROM EMPLOYEE
 WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J2' AND SALARY>=2000000;
 
 -------실습문제------
 --1. 사수가 없고 부서배치도 받지 않은 사원들의 사원명, 사번, 부서코드 조회
 SELECT EMP_NAME, EMP_ID, DEPT_CODE
  FROM EMPLOYEE
 WHERE MANEGER_ID IS NULL AND DEPT_CODE IS NOT NULL; 
 
 --2. 연봉(보너스포함X)이 3000만원 이상이고 보너스를 받지 않은 사원들의 사번, 사원명, 연봉, 보너스 조회
 SELECT EMP_ID, EMP_NAME, SALARY*12, BONUS
  FROM EMPLOYEE
 WHERE SALARY*12 >=30000000 AND BONUS IS NOT NULL; 
 
 --3. 입사일이 95/01/01이상이고 부서배치를 받은 사원들의 사번, 사원명, 입사일, 부서코드 조회
  SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
  FROM EMPLOYEE
 WHERE HIRE_DATE >= 95/01/01 AND DEPARTMENT IS NULL; 
 
 -- 4. 급여가 200만원 이상 500만원 이하고 입사일이 01/01/01이상이고 보너스를 받지 않는 사원들의
 -- 사번, 사원명, 급여, 입사일, 보너스 조회
 SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE, BONUS
  FROM EMPLOYEE
 WHERE 2000000 <= SALARY AND SALARY <=5000000 AND HIRE_DATE >= 01/01/01/ AND BONUS IS NOT NULL;
 -- 5. 보너스포함 연봉이 NULL이 아니고 이름에 '하'가 포함되어 있는 사원들의 사번, 사원명, 급여,
 -- 보너스 포함 연봉 조회(별칭부여)
 SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12+BONUS
  FROM EMPLOYEE
 WHERE HIRE_DATE >= 95/01/01 AND DEPARTMENT IS NULL; 
 
 ---------------------------------------------
 /*
    <ORDER BY절>
    데이터를 정렬하여 보여줌
    SELECT문의 가장 마지막 줄에 작성 뿐만 아니라 실행 순서도 마지막에 실행
    
    [표현법]
    SELECT 조회할 컬럼1, 컬럼2,...
    FROM 테이블명
    WHERE 조건식
    ORDER BY 정렬기준의 컬럼명 | 별칭 | 컬럼순번[ASCIDESC] [NULLS FIRST | NULLS LAST];
    
    - ASC : 오름차순 정력(생략시 기본값)
    - DESC : 내림차순 정렬
    
    - NULLS FIRST : 컬럼값에 NULL이 있을 경우 맨앞에 배치(DESC 일때의 기본값)
    - NULLS LAST : 컬럼값에 NULL이 있을 경우 맨뒤에 배치(생략시 A$C일때의 기본값)
 */
 SELECT *
  FROM EMPLOYEE
 -- ORDER BY BONUS;
 -- ORDER BY BONUS ASC;
 -- ORDER BY BONUS NULLS FIRST;
 
 -- ORDER BY BONUS DESC;       --내림차순 정렬
 ORDER BY BONUS DESC. SALARY;       -- 정렬기준 여러개일 때, 앞을 기준으로 정렬하고 값이 같으면 뒤에 기준으로 정렬
 
 -- 모든 사원의 사원명, 연봉 조회 이때, 연봉의 내림차순 정렬 조회
 SELECT EMP_NAME SALARY*12 "연봉"
  FROM EMPLOYEE
 -- ORDER BY SALARY*12 DESC;
 -- ORDER BY 연봉 DESC;       -- 별칭 사용 가능
 ORDER BY 2 DESC;            -- 2번째 컬럼
 --------------종합문제---------------
--1. JOB테이블에서 모든 정보 조회
SELECT *
 FROM JOB;
-- 2. JOP테이블에서 직급 이름 조회
SELECT jop_name
 FROM JOB;
-- 3. EMPLOYEE테이블에서 DEPARTMENT 테이블의 모든 정보 조회
SELECT EMPLOYEE
 FROM DEPARTMENT; 
-- 4. EMPLOYEE테이블의 직원명, 이메일, 전화번호, 고용일 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
 FROM EMPLOYEE;
-- 5. EMPLOYEE테이블의 고용일, 사원 이름, 월급 조회
SELECT HIRE_DATE, EMP_NAME, SALARY
 FROM EMPLOYEE;
-- 6. EMPLOYEE테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액 - (연봉*세금 3%)) 조회
SELECT EMP_NAME, SALARY*12, (SALARY+BONUS*SALARY)*12, (SALARY+BONUS*SALARY)*12-(SALARY*12*0.3)
 FROM EMPLOYEE;
-- 7. EMPLOYEE테이블에서 JOB_CODE가 J1인 사원의 이름, 월급, 고용일, 연락처 조회
SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
 FROM EMPLOYEE;
WHERE JOBCODE = 'J1';
-- 8. EMPLOYEE테이블에서 실수령액(6번 참고)이 5천만원 이상인 사원의 이름, 월급, 실수령액, 고용일 조회
SELECT EMP_NAME, SALARY, (SALARY+BONUS*SALARY)*12-(SALARY*12*0.3), HIRE_DATE
 FROM EMPLOYEE;
WHERE (SALARY+BONUS*SALARY)*12-(SALARY*12*0.3) >= 50000000; 
-- 9. EMPLOYEE테이블에 월급이 4000000이상이고 JOB_CODE가 J2인 사원의 전체 내용 조회
SELECT *
 FROM EMPLOYEE;
WHERE SALARY >= 40000000 AND JOB_CODE = 'J2';
-- 10. EMPLOYEE테이블에 DEPT_CODE가 D9이거나 D5인 사원 중 
--     고용일이 02년 1월 1일보다 빠른 사원의 이름, 부서코드, 고용일 조회
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
 FROM EMPLOYEE;
WHERE DEPT_CODE = 'D9' OR 'D5' AND HIRE_DATE >= '02/01/01';
-- 11. EMPLOYEE테이블에 고용일이 90/01/01 ~ 01/01/01인 사원의 전체 내용을 조회
SELECT *
 FROM EMPLOYEE;
 WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/01/01';
-- 12. EMPLOYEE테이블에서 이름 끝이 '연'으로 끝나는 사원의 이름 조회
SELECT EMP_NAME
 FROM EMPLOYEE;
 WHERE EMP_NAME = '%연';
-- 13. EMPLOYEE테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 조회
SELECT EMP_NAME, PHONE
 FROM EMPLOYEE;
 WHERE EMP_NAME NOT LIKE '010%';
-- 14. EMPLOYEE테이블에서 메일주소 '_'의 앞이 4자이면서 DEPT_CODE가 D9 또는 D6이고 
--     고용일이 90/01/01 ~ 00/12/01이고, 급여가 270만 이상인 사원의 전체를 조회
SELECT *
 FROM EMPLOYEE;
 WHERE EMAIL = '___%' AND DEPT_CODE = 'D9', 'D6',
            AND HIRE_DATE >= '90/01/01' 
            AND HIRE_DATE <= '00/12/01'; 
            AND SALARY >= 2700000;