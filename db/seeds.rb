# 관리자와 일반 사용자 생성
admin = User.create!(
  email: 'admin@example.com',
  password: 'password123',
  name: '관리자',
  role: :admin
)

user = User.create!(
  email: 'user@example.com',
  password: 'password123',
  name: '사용자',
  role: :user
)

# 테스트 생성
test = Test.create!(
  title: "프로그래머스 코딩테스트",
  description: "프로그래머스 백엔드 개발자 채용 코딩테스트"
)

# 1. 예약 가능한 미래 일정
schedule1 = TestSchedule.create!(
  test: test,
  start_time: Time.current + 1.month,
  end_time: Time.current + 1.month + 2.hours,
)

# 2. 마감된 미래 일정 (정원 초과)
schedule2 = TestSchedule.create!(
  test: test,
  start_time: Time.current + 2.months,
  end_time: Time.current + 2.months + 2.hours,
  number_of_participants: TestSchedule::MAX_CAPACITY
)

# 3. 마감된 미래 일정 (deadline 강제 삽입)
TestSchedule.insert_all!([
  {
    test_id: test.id,
    start_time: Time.current + 1.day,
    end_time: Time.current + 1.day + 2.hours,
    deadline: Time.current - 1.day,  # 과거 시간으로 강제 설정
    number_of_participants: 0,
    created_at: Time.current,
    updated_at: Time.current
  }
])

schedule3 = TestSchedule.last

# 예약 생성 (participants 필드 추가)
Reservation.insert_all!([
  {
    user_id: user.id,
    test_schedule_id: schedule1.id,
    status: 0,  # pending
    participants: 10000,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    user_id: user.id,
    test_schedule_id: schedule2.id,
    status: 1,  # confirmed
    participants: 50000,
    created_at: Time.current,
    updated_at: Time.current
  },
  {
    user_id: user.id,
    test_schedule_id: schedule3.id,
    status: 2,  # rejected
    participants: 50000,
    created_at: Time.current,
    updated_at: Time.current
  }
])